data "aws_eks_addon_version" "latest" {
  for_each = var.addons != {} ? var.addons : {}

  addon_name         = each.key
  kubernetes_version = var.cluster_version
  most_recent        = true
}

resource "aws_eks_addon" "addons" {
  for_each = var.addons != {} ? var.addons : {}

  cluster_name                = var.eks_cluster_id
  addon_name                  = each.value.name
  addon_version               = data.aws_eks_addon_version.latest[each.key].version
  service_account_role_arn    = aws_iam_role.this[each.key].arn
  resolve_conflicts_on_update = "OVERWRITE"
}

data "aws_iam_policy_document" "example_assume_role_policy" {
  for_each = var.addons != {} ? var.addons : {}

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.openid_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:${each.value.serviceaccount}"]
    }

    principals {
      identifiers = [var.openid_connect]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "this" {
  for_each = var.addons != {} ? var.addons : {}

  assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy[each.key].json
  name               = each.key
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.addons != {} ? var.addons : {}

  policy_arn = each.value.policy_arn
  role       = aws_iam_role.this[each.key].name
}
