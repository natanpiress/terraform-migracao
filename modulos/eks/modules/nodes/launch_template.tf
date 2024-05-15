data "aws_ami" "eks-worker" {
  count = var.launch_create ? 1 : 0
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-*"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_launch_template" "this" {
  count = var.launch_create ? 1 : 0

  name                   = format("%s-%s", var.name, var.environment)
  update_default_version = true

  monitoring {
    enabled = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.volume-size != "" ? var.volume-size : 20
      volume_type           = var.volume-type != "" ? var.volume-type : "gp3"
      delete_on_termination = true
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      associate_public_ip_address = try(network_interfaces.value.associate_public_ip_address, false)
      delete_on_termination       = try(network_interfaces.value.delete_on_termination, true)
      security_groups             = try(network_interfaces.value.security_groups, [])
      subnet_id                   = try(network_interfaces.value.subnet_id, null)
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.launch_create && var.asg_create ? [1] : []

    content {
      name = var.iam_instance_profile
    }
  }

  image_id      = data.aws_ami.eks-worker[0].id
  instance_type = var.instance_types_launch

  user_data = base64encode(<<-EOT
  MIME-Version: 1.0
  Content-Type: multipart/mixed; boundary="//"
  
  --//
  Content-Type: text/x-shellscript; charset="us-ascii"
  #!/bin/bash
    
  if [ ${var.use-max-pods} = true ]; then
    /etc/eks/bootstrap.sh ${var.cluster_name} --b64-cluster-ca ${var.certificate_authority} --apiserver-endpoint ${var.endpoint} --use-max-pods=${var.use-max-pods}  --kubelet-extra-args '--max-pods=${var.max-pods} ${var.taints_lt} ${var.labels_lt}'
  else
    /etc/eks/bootstrap.sh ${var.cluster_name} --b64-cluster-ca ${var.certificate_authority} --apiserver-endpoint ${var.endpoint} --kubelet-extra-args '${var.taints_lt} ${var.labels_lt}'
  fi
  --//--
  EOT
  )

  tags = {
    Name        = format("%s-%s", var.name, var.environment)
    Environment = var.environment
    Platform    = "k8s"
    Type        = "launch-template"
  }

  dynamic "tag_specifications" {
    for_each = var.tag_specifications
    content {
      resource_type = tag_specifications.value.resource_type

      tags = tag_specifications.value.tags
    }

  }

  lifecycle {
    create_before_destroy = true
  }
}

