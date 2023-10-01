# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  # Bucket Naming Rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
    Hello    = "world"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "index.html"
  source       = "${path.root}${var.index_html_filepath}"
  content_type = "text/html"

  etag = filemd5("${path.root}${var.index_html_filepath}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes       = [etag]
  }
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "error.html"
  source       = "${path.root}${var.error_html_filepath}"
  content_type = "text/html"

  etag = filemd5("${path.root}${var.error_html_filepath}")
}

# resource "aws_s3_object" "pre_js" {
#   bucket       = aws_s3_bucket.website_bucket.bucket
#   key          = "pre.js"
#   source       = var.pre_js_filepath
#   content_type = "text/javascript"

#   etag = filemd5(var.pre_js_filepath)
# }


# resource "aws_s3_object" "random_js" {
#   bucket       = aws_s3_bucket.website_bucket.bucket
#   key          = "random.js"
#   source       = var.random_js_filepath
#   content_type = "text/javascript"

#   etag = filemd5(var.random_js_filepath)
# }

# resource "aws_s3_object" "styles_css" {
#   bucket       = aws_s3_bucket.website_bucket.bucket
#   key          = "styles.css"
#   source       = var.styles_css_filepath
#   content_type = "text/css"

#   etag = filemd5(var.styles_css_filepath)
# }

# resource "aws_s3_object" "upload_assets" {
#   for_each = fileset("${path.root}/public/assets", "*.{jpg,png,gif,svg,mp3}")
#   bucket   = aws_s3_bucket.website_bucket.bucket
#   key      = "assets/${each.key}"
#   source   = "${path.root}/public/assets/${each.key}"

#   etag = filemd5("${path.root}/public/assets/${each.key}")
#   lifecycle {
#     replace_triggered_by = [terraform_data.content_version.output]
#     ignore_changes       = [etag]
#   }
# }

# https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  #policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  # Inline but could be created on aws and reference or in a seperate file locally.
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid"    = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action"   = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
      # "Condition" = {
      # "StringEquals" = {
      #     # https://developer.hashicorp.com/terraform/language/data-sources
      #     #"AWS:SourceArn": data.aws_caller_identity.current.arn
      #     "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
      #   }
      # }
    }
  })
}

# resource "terraform_data" "content_version" {
#   input = var.content_version
# }
