module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  endpoint_public_access = true

  enable_irsa = true

  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {

    application = {

    instance_types = [var.instance_type]

    ami_type = "AL2023_x86_64_STANDARD"

    desired_size = 4
    min_size     = 4
    max_size     = 6

    subnet_ids = module.vpc.private_subnets

    labels = {
      workload = "application"
    }



  }

  }

  tags = {
    Terraform  = "true"
    Environment = "dev"
  }
}



module "ebs_csi_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.50"

  role_name = "${var.cluster_name}-ebs-csi"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn

      namespace_service_accounts = [
        "kube-system:ebs-csi-controller-sa"
      ]
    }
  }
}