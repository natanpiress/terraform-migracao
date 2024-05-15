provider "aws" {
  profile = ""
  region  = ""
}

locals {
  environment = "hmg"
  tags = {
    Environment = "hmg"
  }
  cluster_name = "k8s"

  public_subnets_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared",
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnets_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared",
    "kubernetes.io/role/internal-elb"             = 1
  }

}

#### VPC
module "vpc" {
  source = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules/vpc?ref=main"

  name                 = "vpc-k8s"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags

  private_subnets         = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  map_public_ip_on_launch = true
  environment             = local.environment

  public_subnets_tags  = local.public_subnets_tags
  private_subnets_tags = local.private_subnets_tags

  igwname = "igw-k8s"
  natname = "nat-k8s"
  rtname  = "rt-k8s"
}

## EKS

module "eks" {
  source = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules/eks-terraform?ref=main"

  cluster_name            = local.cluster_name
  kubernetes_version      = "1.24"
  subnet_ids              = concat(tolist(module.vpc.private_ids), tolist(module.vpc.public_ids))
  environment             = local.environment
  endpoint_private_access = true
  endpoint_public_access  = true

  private_subnet = module.vpc.private_ids

  tags = local.tags
  
  ## Addons EKS
  create_ebs     = false
  create_core    = false
  create_vpc_cni = false
  create_proxy   = false

  ## Controller EBS Helm
  aws-ebs-csi-driver = false

  ## Configuration custom values
  #custom_values_ebs = {
  #  values = [templatefile("${path.module}/values-ebs.yaml", {
  #    aws_region   = "us-east-1"
  #    cluster_name = "${local.cluster_name}"
  #  })]
  #}

  ## External DNS 
  external-dns = false

  ## Controller ASG
  aws-autoscaler-controller = false

  ## Controller ALB
  aws-load-balancer-controller = false

  ## Custom values example
  custom_values_alb = {
    set = [
      {
        name  = "nodeSelector.Environment"
        value = local.environment
      },
      {
        name  = "vpcId" ## Variable obrigatory for controller alb
        value = module.vpc.vpc_id
      },
      {
        name  = "tolerations[0].key"
        value = "environment"
      },
      {
        name  = "tolerations[0].operator"
        value = "Equal"
      },
      {
        name  = "tolerations[0].value"
        value = local.environment
      },
      {
        name  = "tolerations[0].effect"
        value = "NoSchedule"
      }
    ]
  }

  ## CUSTOM_HELM

  custom_helm = {
    aws-secrets-manager = {
      name             = "aws-secrets-manager"
      namespace        = "kube-system"
      repository       = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
      chart            = "secrets-store-csi-driver-provider-aws"
      version          = "0.3.4"
      create_namespace = false
      #values = file("${path.module}/values.yaml")
      values = []
    }
    secret-csi = {
      name             = "secret-csi"
      namespace        = "kube-system"
      repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
      chart            = "secrets-store-csi-driver"
      version          = "v1.3.4"
      create_namespace = false
      #values = file("${path.module}/values.yaml")
      values = []
    }
  }

  ## NODES
  nodes = {
    infra = {
      create_node             = true
      node_name               = "infra"
      cluster_version_manager = "1.24"
      desired_size            = 1
      max_size                = 5
      min_size                = 1
      instance_types          = ["t3.medium"]
      disk_size               = 20
      capacity_type           = "SPOT"
    }
    infra-lt = {
      create_node           = false
      launch_create         = false
      name_lt               = "lt"
      node_name             = "infra-lt"
      cluster_version       = "1.24"
      desired_size          = 1
      max_size              = 3
      min_size              = 1
      instance_types_launch = "t3.medium"
      volume-size           = 20
      volume-type           = "gp3"

      labels = {
        Environment = "${local.environment}"
      }

      taints = {
        dedicated = {
          key    = "environment"
          value  = "${local.environment}"
          effect = "NO_SCHEDULE"
        }
      }
    }

    infra-fargate = {
      create_fargate       = false
      fargate_auth         = false
      fargate_profile_name = "infra-fargate"
      selectors = [
        {
          namespace = "kube-system"
          labels = {
            k8s-app = "kube-dns"
          }
        },
        {
          namespace = "default"
        }
      ]
    }
    infra-asg = {
      launch_create         = false
      asg_create            = false
      cluster_version       = "1.23"
      name_lt               = "lt-asg"
      desired_size          = 1
      max_size              = 2
      min_size              = 1
      instance_types_launch = "t3.medium"
      volume-size           = 20
      volume-type           = "gp3"
      taints_lt             = "--register-with-taints=dedicated=${local.environment}:NoSchedule"
      labels_lt             = "--node-labels=eks.amazonaws.com/nodegroup=infra"
      name_asg              = "infra"
      vpc_zone_identifier   = "${module.vpc.private_ids}"
      asg_tags = [
        {
          key                 = "Environment"
          value               = "${local.environment}"
          propagate_at_launch = true
        },
        {
          key                 = "Name"
          value               = "${local.environment}"
          propagate_at_launch = true
        },
        {
          key                 = "kubernetes.io/cluster/${local.cluster_name}"
          value               = "owner"
          propagate_at_launch = true
        },
      ]
    }
  }

}

