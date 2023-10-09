output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.soul_house_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website Hosting Endpoint"
  value       = module.soul_house_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value       = module.soul_house_hosting.cloudfront_url
}