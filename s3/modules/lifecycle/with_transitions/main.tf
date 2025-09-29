resource "aws_s3_bucket_lifecycle_configuration" "with_transitions" {
    bucket = var.bucket_id

    rule {
        id     = var.rule_id
        status = "Enabled"

        filter {
            prefix = var.prefix
        }

        expiration {
            days = var.expiration_days
        }

        transition {
            days          = var.transition_days_ia
            storage_class = "STANDARD_IA"
        }

        transition {
            days          = var.transition_days_glacier
            storage_class = "GLACIER"
        }

        noncurrent_version_expiration {
            noncurrent_days = var.noncurrent_days
        }

        abort_incomplete_multipart_upload {
            days_after_initiation = var.days_after_initiation
        }
    }
}