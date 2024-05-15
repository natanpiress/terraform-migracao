module "ebs" {
  source = "./modules/addons"
  count  = var.create_ebs ? 1 : 0

  eks_cluster_id  = aws_eks_cluster.eks_cluster.id
  openid_connect  = aws_iam_openid_connect_provider.this.arn
  openid_url      = aws_iam_openid_connect_provider.this.url
  cluster_version = aws_eks_cluster.eks_cluster.version

  addons = {
    "aws-ebs-csi-driver" = {
      "name"           = "aws-ebs-csi-driver"
      "serviceaccount" = "ebs-csi-controller-sa"
      "policy_arn"     = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    }
  }
}

module "core" {
  source = "./modules/addons"
  count  = var.create_core ? 1 : 0

  eks_cluster_id  = aws_eks_cluster.eks_cluster.id
  openid_connect  = aws_iam_openid_connect_provider.this.arn
  openid_url      = aws_iam_openid_connect_provider.this.url
  cluster_version = aws_eks_cluster.eks_cluster.version

  addons = {
    "coredns" = {
      "name"           = "coredns"
      "serviceaccount" = "aws-node"
      "policy_arn"     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    }
  }

}

module "vpc-cni" {
  source = "./modules/addons"
  count  = var.create_vpc_cni ? 1 : 0

  eks_cluster_id  = aws_eks_cluster.eks_cluster.id
  openid_connect  = aws_iam_openid_connect_provider.this.arn
  openid_url      = aws_iam_openid_connect_provider.this.url
  cluster_version = aws_eks_cluster.eks_cluster.version

  addons = {
    "vpc-cni" = {
      "name"           = "vpc-cni"
      "serviceaccount" = "aws-node"
      "policy_arn"     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    }
  }
}

module "proxy" {
  source = "./modules/addons"
  count  = var.create_proxy ? 1 : 0

  eks_cluster_id  = aws_eks_cluster.eks_cluster.id
  openid_connect  = aws_iam_openid_connect_provider.this.arn
  openid_url      = aws_iam_openid_connect_provider.this.url
  cluster_version = aws_eks_cluster.eks_cluster.version

  addons = {
    "kube-proxy" = {
      "name"           = "kube-proxy"
      "serviceaccount" = "aws-node"
      "policy_arn"     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    }
  }
}