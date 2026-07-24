# Example Terraform variables file
# Copy this file to terraform.tfvars and fill in your actual values
# DO NOT commit terraform.tfvars to version control

# Required: Route 53 hosted zone ID for your domain
# Example: Z1234567890ABC
route53_zone_id = "Z1234567890ABC"

# Required: ACM certificate ARN (must be in us-east-1)
# Example: arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-5678-90ef-ghij-klmnopqrstuv
acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-5678-90ef-ghij-klmnopqrstuv"

# Optional: Domain name (default shown)
# domain_name = "edwinkinloch.com"

# Optional: S3 bucket name prefix (default shown)
# bucket_name_prefix = "edwinkinloch-website"

# Optional: Create www subdomain record (default shown)
# create_www_record = true

# Optional: CloudFront price class (default shown)
# Options: PriceClass_All, PriceClass_100, PriceClass_200
# cloudfront_price_class = "PriceClass_100"
