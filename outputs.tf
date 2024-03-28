output "iam_role_arn" {
  value = aws_iam_role.terrateam_role.arn
  description = "The ARN of the created IAM role"
}
