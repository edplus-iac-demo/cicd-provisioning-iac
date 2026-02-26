variable "github_organization" {
  description = "GitHub Organization Name"
  type        = string
}

variable "app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "app_installation_id" {
  description = "GitHub Installation ID"
  type        = string
}

variable "app_pem_file" {
  description = "GitHub App Private Key PEM file content"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to be stored in repository environment secrets"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "CloudFront Distribution ID to be stored in repository environment secrets"
  type        = string
}

variable "aws_region" {
  description = "AWS Region to be stored in repository environment secrets"
  type        = string
}

variable "aws_oidc_role_arn" {
  description = "OIDC Role ARN to be stored in repository environment secrets"
  type        = string
}

variable "repository_name" {
  description = "Name of the GitHub repository to configure"
  type        = string
}

variable "environment" {
  description = "Name of the enviornment"
  type        = string
}

variable "is_spa" {
  description = "Boolean to determine if the frontend is a SPA"
  type        = bool
}
