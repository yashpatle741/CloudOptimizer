# CloudOptimizer Terraform Infrastructure

This directory contains modular Terraform code for a production-ready AWS deployment of the CloudOptimizer platform.

## Modules

- IAM: least-privilege Lambda execution role and policy
- CloudWatch: log groups and optional alarm
- Lambda: scanner function with environment variables and concurrency controls
- EventBridge: scheduled trigger for the scanner Lambda
- DynamoDB: results storage with encryption and PITR
- SNS: notifications with email and Lambda subscription support
- S3: reports bucket with versioning, encryption, and lifecycle rules
- API Gateway: HTTP API with Lambda proxy integration and CORS

## Usage

1. Copy terraform.tfvars.example to terraform.tfvars.
2. Update values for your environment.
3. Run terraform init.
4. Run terraform plan and terraform apply.
