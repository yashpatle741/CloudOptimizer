# IAM Module

This module provisions a least-privilege IAM role and policy for CloudOptimizer Lambda functions.

## What it creates

- A Lambda execution role with a trust policy for `lambda.amazonaws.com`
- A custom IAM policy granting only the required permissions for:
  - DynamoDB read/write
  - SNS publish
  - Cost Explorer read
  - EC2 `Describe*`
  - EBS `Describe*`
  - S3 read-only access
  - AWS-managed Lambda basic execution permissions

## Example usage

```hcl
module "iam" {
  source = "./modules/iam"

  project_name       = "CloudOptimizer"
  environment        = "dev"
  aws_region         = "us-east-1"
  dynamodb_table_arns = ["arn:aws:dynamodb:us-east-1:123456789012:table/cloudoptimizer-dev-results"]
  sns_topic_arns     = ["arn:aws:sns:us-east-1:123456789012:cloudoptimizer-dev-notifications"]
  s3_bucket_arns     = ["arn:aws:s3:::cloudoptimizer-dev-reports"]
}
```
