# Terraform S3 Backend with DynamoDB State Locking
#
# The S3 bucket (edwinkinloch-tfstate-918551678389) and DynamoDB lock table
# (edwinkinloch-tfstate-lock) were created out-of-band via AWS CLI.
# These resources are not managed by this Terraform config to avoid a
# chicken-and-egg bootstrap problem (you can't store Terraform state
# before you have a place to store it).
terraform {
  backend "s3" {
    bucket         = "edwinkinloch-tfstate-918551678389"
    key            = "glm-code/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "edwinkinloch-tfstate-lock"
  }
}
