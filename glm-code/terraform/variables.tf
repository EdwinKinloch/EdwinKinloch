variable "domain_name" {
  description = "Primary domain name (e.g., 'edwinkinloch.com')"
  type        = string
  default     = "edwinkinloch.com"
}

variable "bucket_name_prefix" {
  description = "Prefix for S3 bucket name (will have random suffix appended)"
  type        = string
  default     = "edwinkinloch-website"
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID for the domain"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "PersonalWebsite"
    ManagedBy   = "Terraform"
    Environment = "production"
  }
}

variable "create_www_record" {
  description = "Whether to create www subdomain record"
  type        = bool
  default     = true
}

variable "cloudfront_price_class" {
  description = "CloudFront price class for cost optimization"
  type        = string
  default     = "PriceClass_100"
  validation {
    condition     = contains(["PriceClass_All", "PriceClass_100", "PriceClass_200"], var.cloudfront_price_class)
    error_message = "Price class must be PriceClass_All, PriceClass_100, or PriceClass_200."
  }
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for the domain (must be in us-east-1)"
  type        = string
}
