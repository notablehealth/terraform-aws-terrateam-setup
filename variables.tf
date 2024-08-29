variable "create_oidc_provider" {
  description = "Whether to create the Github OIDC Provider resource"
  type        = bool
  default     = true
}

variable "github_org" {
  description = "The GitHub organization for which the OIDC provider is set up"
  type        = string

  validation {
    condition     = var.github_org != "GITHUB_ORG"
    error_message = "The GitHub organization must not be 'GITHUB_ORG'."
  }
}

variable "repositories" {
  description = "Restrict to one or more repositories"
  type        = list(string)
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
