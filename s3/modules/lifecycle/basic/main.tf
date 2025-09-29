resource "aws_s3_bucket_lifecycle_configuration" "basic" {
    bucket = var.bucket_id

    rule {
        id     = var.rule_id
        status = "Enabled"

        filter {
            prefix = var.prefix
        }

        noncurrent_version_expiration {
            noncurrent_days = var.noncurrent_days
        }

        abort_incomplete_multipart_upload {
            days_after_initiation = var.days_after_initiation
        }
    }
}
