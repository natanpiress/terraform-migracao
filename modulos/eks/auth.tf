locals {
  aws_auth_configmap_data = {
    mapRoles = yamlencode(concat([
      {
        rolearn  = "${aws_iam_role.node.arn}"
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
        ]
      },
      var.fargate_auth ? {
        rolearn  = "${aws_iam_role.this[0].arn}"
        username = "system:node:{{SessionName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
          "system:node-proxier"
        ]
      } : null
      ],
    var.mapRoles))
    mapUsers    = yamlencode(var.mapUsers)
    mapAccounts = yamlencode(var.mapAccounts)
  }
}

resource "kubernetes_config_map" "aws_auth" {
  count = var.create_aws_auth_configmap ? 1 : 0

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = local.aws_auth_configmap_data

  lifecycle {
    ignore_changes = [data, metadata[0].labels, metadata[0].annotations]
  }
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  count = var.manage_aws_auth_configmap ? 1 : 0

  force = true

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = local.aws_auth_configmap_data
  
  depends_on = [ 
    module.nodes
  ]
}