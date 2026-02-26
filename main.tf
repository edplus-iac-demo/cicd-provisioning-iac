provider "github" {
  owner = var.github_organization
  app_auth {
    id              = var.app_id
    installation_id = var.app_installation_id
    pem_file        = var.app_pem_file
  }
}

resource "github_repository_environment" "envs" {
  repository  = var.repository_name
  environment = var.environment
  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_environment_deployment_policy" "env_policy" {
  repository     = var.repository_name
  environment    = var.environment
  branch_pattern = var.environment
  depends_on     = [github_repository_environment.envs]
}

resource "github_actions_environment_secret" "s3_bucket_name" {
  repository      = var.repository_name
  environment     = var.environment
  secret_name     = "S3_BUCKET_NAME"
  plaintext_value = var.s3_bucket_name
  depends_on      = [github_repository_environment.envs]
}

resource "github_actions_environment_secret" "cloudfront_distribution_id" {
  repository      = var.repository_name
  environment     = var.environment
  secret_name     = "CLOUDFRONT_DISTRIBUTION_ID"
  plaintext_value = var.cloudfront_distribution_id
  depends_on      = [github_repository_environment.envs]
}

resource "github_actions_environment_secret" "aws_region" {
  repository      = var.repository_name
  environment     = var.environment
  secret_name     = "AWS_REGION"
  plaintext_value = var.aws_region
  depends_on      = [github_repository_environment.envs]
}

resource "github_actions_environment_secret" "aws_oidc_role_arn" {
  repository      = var.repository_name
  environment     = var.environment
  secret_name     = "AWS_OIDC_ROLE_ARN"
  plaintext_value = var.aws_oidc_role_arn
  depends_on      = [github_repository_environment.envs]
}

resource "github_repository_file" "frontend_workflow" {
  repository          = var.repository_name
  branch              = var.environment
  file                = ".github/workflows/deploy-frontend-${var.environment}.yml"
  content             = var.is_spa ? file("${path.module}/files/spa-deploy.yml") : file("${path.module}/files/ssg-deploy.yml")
  commit_message      = "Add CI/CD frontend workflow for ${var.environment} environment"
  overwrite_on_create = true
  depends_on = [
    github_repository_environment_deployment_policy.env_policy,
    github_actions_environment_secret.s3_bucket_name,
    github_actions_environment_secret.cloudfront_distribution_id,
    github_actions_environment_secret.aws_region,
    github_actions_environment_secret.aws_oidc_role_arn,
  ]
  lifecycle {
    ignore_changes = [content]
  }
}
