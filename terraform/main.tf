provider "aws" {
  profile = "personal"
  # region = "us-east-1"
}

# data "aws_region" "current" {}

# output "echo" {
#   value       = data.aws_region.current.name
# }

locals {
  s3_origin_id = "myS3Origin"
}

data "aws_s3_bucket" "mine" {
  bucket = "pythoninthegrass-cloud-resume"
}

# resource "aws_cloudfront_origin_access_control" "example" {
#   name                              = "example"
#   description                       = "Example Policy"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

resource "aws_acm_certificate" "cert" {
  domain_name       = "example.com"
  # validation_method = "EMAIL"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = data.aws_s3_bucket.mine.bucket_regional_domain_name
    # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  # extra CNAMEs
  # aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }

  tags = {
    Environment = "prod"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
