resource "aws_eks_addon" "vpc_cni" {

  cluster_name = module.eks.cluster_name
  addon_name   = "vpc-cni"

  depends_on = [
    module.eks
  ]
}

resource "aws_eks_addon" "kube_proxy" {

  cluster_name = module.eks.cluster_name
  addon_name   = "kube-proxy"

  depends_on = [
    module.eks
  ]
}

resource "aws_eks_addon" "coredns" {

  cluster_name = module.eks.cluster_name
  addon_name   = "coredns"

  depends_on = [
    aws_eks_addon.vpc_cni
  ]
}

resource "aws_eks_addon" "ebs_csi_driver" {

  cluster_name = module.eks.cluster_name
  addon_name   = "aws-ebs-csi-driver"

  service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn

  depends_on = [
    module.eks,
    module.ebs_csi_irsa_role
  ]
}