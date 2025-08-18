module "github_oidc_provider" {
  source  = "philips-labs/github-oidc/aws//modules/provider"
  version = "0.7.1"
}

module "github_oidc_configuration" {
  source  = "philips-labs/github-oidc/aws"
  version = "0.7.1"

  openid_connect_provider_arn = module.github_oidc_provider.openid_connect_provider.arn
  repo                        = "cterence/xit"
  default_conditions          = ["allow_all"]
  role_policy_arns = [
    module.github_oidc_policy.arn,
  ]
}

data "aws_iam_policy_document" "github_oidc" {
  statement {
    sid    = "AllowEC2"
    effect = "Allow"

    actions = [
      "ec2:*",
    ]

    resources = [
      "*",
    ]
  }
}

module "github_oidc_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.1.0"

  description = "Policy for GitHub OIDC"
  name        = "github-oidc-policy"
  path        = "/github-actions/"
  policy      = data.aws_iam_policy_document.github_oidc.json
}
