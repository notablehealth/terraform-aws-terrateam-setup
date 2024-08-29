
data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  count = var.create_oidc_provider ? 1 : 0

  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
}

locals {
  github_scope = length(var.repositories) > 1 ? "multiple-repo" : (length(var.repositories) == 1 ? "single-repo" : "org")
  scope = {
    "multiple-repo" = jsonencode(
      [for repo in var.repositories : "repo:${var.github_org}/${repo}:*"]
    )
    "single-repo" = "repo:${var.github_org}/${var.repositories[0]}:*"
    "org"         = "repo:${var.github_org}/*"
  }
}

resource "aws_iam_role" "terrateam_role" {
  name = var.aws_iam_role_name
  assume_role_policy = templatefile(
    "${path.module}/templates/trust-policy.json.tftpl",
    {
      aws_account_id = data.aws_caller_identity.current.account_id
      scope          = local.scope[local.github_scope]
    }
  )
}

resource "aws_iam_role_policy_attachment" "terrateam_iam_role_policy_attachment" {
  role       = aws_iam_role.terrateam_role.name
  policy_arn = var.aws_policy_arn
}
