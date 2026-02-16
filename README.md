# CI/CD Provisioning IAC

## Description
Uses Terraform to create Github Actions pipelines that can deploy websites to existing S3 and CloudFront setups.

## Instructions

1.  Run the GitHub Actions workflow. The workflow requires:
   - AWS Account ID
   - Repository Name
   - Repository Environment
   - S3 Bucket Name
   - CloudFront Distribution ID
   - AWS Region
   - Enable SPA redirect (true/false)
2. Review the Terraform plan produced by the workflow and approve the apply (the apply job is gated by an environment approval).
