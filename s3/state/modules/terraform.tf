resource "aws_s3_bucket" "terraform_state_bucket" {
    bucket = "${var.project_name}-terraform-state-${var.environment}-${var.region}"
    
    tags = merge(var.common_tags, {
        Name    = "${var.project_name}-terraform-state-${var.environment}-${var.region}"
        Purpose = "Terraform State Storage"
        Region  = var.region
    })
}

# Versioning
resource "aws_s3_bucket_versioning" "terraform_state_bucket" {
    bucket = aws_s3_bucket.terraform_state_bucket.id
    
    versioning_configuration {
        status = "Enabled"
    }
}

# Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket" {
    bucket = aws_s3_bucket.terraform_state_bucket.id

    rule {
        bucket_key_enabled = true
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Public access
resource "aws_s3_bucket_public_access_block" "terraform_state_bucket" {
    bucket = aws_s3_bucket.terraform_state_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Lifecycle
resource "aws_s3_bucket_lifecycle_configuration" "terraform_state_bucket" {
    bucket = aws_s3_bucket.terraform_state_bucket.id

    rule {
        id     = "terraform_state_lifecycle"
        status = "Enabled"

        filter {
            prefix = ""
        }

        noncurrent_version_expiration {
            noncurrent_days = 30
        }

        abort_incomplete_multipart_upload {
            days_after_initiation = 7
        }
    }
}
