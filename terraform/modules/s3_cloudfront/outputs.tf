output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.frontend_bucket.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.cdn.domain_name
}
