locals {
  environment = "producao"
  tags = {
    Environment = "producao"
  }
}

module "vpc" {
  source = "./modulos/vpc"

  name                 = "charlie-prod"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags        = local.tags
  environment = local.environment

  private_subnets         = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  map_public_ip_on_launch = true

  igwname = "my-igw"
  natname = "my-nat"
  rtname  = "my-rt"

  private_subnets_tags = {
    "kubernetes.io/cluster/${module.eks.cluster_name}"   = "shared",
    "kubernetes.io/role/internal-elb" = 1
  }

  public_subnets_tags = {
    "kubernetes.io/cluster/develop" = "shared",
    "kubernetes.io/role/elb"        = 1
  }

  route_table_routes_private = {
    ## add block to create route in subnet-public
    "peer" = {
      "cidr_block"                = "10.10.0.0/16"
      "vpc_peering_connection_id" = "pcx-xxxxxxxxxxxxx"
    }
  }
  route_table_routes_public = {
    ## add block to create route in subnet-private
    "peer" = {
      "cidr_block"                = "10.10.0.0/16"
      "vpc_peering_connection_id" = "pxc-xxxxxxxxxxxxxxx"
    }

  }
}
## EKS
module "eks" {
  source = "./modulos/eks"

  cluster_name            = "charlie"
  kubernetes_version      = "1.29"
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
  ## NODES
  nodes = {
    apps = {
      create_node             = true
      node_name               = "apps"
      cluster_version_manager = "1.29"
      desired_size            = 5
      max_size                = 12
      min_size                = 5
      instance_types          = ["t3.medium"]
      disk_size               = 20
      capacity_type           = "SPOT"
    }
    tools = {
      create_node             = true
      node_name               = "tools"
      cluster_version_manager = "1.29"
      desired_size            = 2
      max_size                = 3
      min_size                = 2
      instance_types          = ["t3.medium"]
      disk_size               = 20
      capacity_type           = "SPOT"

      taints = {
        dedicated = {
          key    = "node_name"
          value  = "tools"
          effect = "NO_SCHEDULE"
        }
      }
      
    }    
    monitoring = {
      create_node           = true
      node_name             = "monitoring"
      cluster_version       = "1.29"
      desired_size          = 2
      max_size              = 3
      min_size              = 2
      instance_types_launch = "t3.medium"
      volume-size           = 20
      volume-type           = "gp3"

      labels = {
        Environment = "${local.environment}"
      }

      taints = {
        dedicated = {
          key    = "node_name"
          value  = "monitoring"
          effect = "NO_SCHEDULE"
        }
      }
    }
  }
}

