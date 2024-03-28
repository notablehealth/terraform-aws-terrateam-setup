variable "github_org" {
  description = "The GitHub organization for which the OIDC provider is set up"
  type        = string
}

variable "aws_policy_arn" {
  description = "The Policy ARN to attach to the IAM role"
  type        = string
  default     = "arn:aws:iam::aws:policy/PowerUserAccess"
}

variable "aws_iam_role_name" {
  description = "The IAM role name"
  type        = string
  default     = "terrateam"
}
