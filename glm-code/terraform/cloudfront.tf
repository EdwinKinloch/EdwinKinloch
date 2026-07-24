# Origin Access Control (OAC - modern approach)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.bucket_name_prefix}-oac"
  description                       = "OAC for ${var.bucket_name_prefix} S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "website" {
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = var.cloudfront_price_class
  http_version        = "http2and3"
  wait_for_deployment = false
  default_root_object = "index.html"

  # Origin
  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = "s3-origin"
  }

  # Default cache behavior
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true

    # Use managed-CachingOptimized policy
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    # Use managed SecurityHeadersPolicy for HSTS, X-Content-Type-Options, etc.
    response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
  }

  # Custom error responses for missing pages
  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  # Viewer certificate - ACM certificate required
  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  # Restrictions - none (public website)
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Alternate domain names
  aliases = var.create_www_record ? [var.domain_name, "www.${var.domain_name}"] : [var.domain_name]

  tags = var.common_tags
}
