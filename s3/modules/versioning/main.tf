resource "aws_s3_bucket_versioning" "main" {
    bucket = var.bucket_id
    
    versioning_configuration {
        status = "Enabled"
    }
}