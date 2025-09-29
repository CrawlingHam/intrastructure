resource "aws_s3_bucket_server_side_encryption_configuration" "aes256" {
    bucket = var.bucket_id

    rule {
        bucket_key_enabled = true
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}