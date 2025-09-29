resource "aws_s3_bucket" "alb_access_logs_bucket" {
    bucket = "${var.project_name}-alb-access-logs-${var.environment}-${var.region}"
    
    tags = merge(local.common_tags, {
        Name    = "${var.project_name}-alb-access-logs-${var.environment}-${var.region}"
        Purpose = "ALB Access Logs Storage"
        Region  = var.region
    })
}

module "versioning" {
    source    = "../modules/versioning"
    bucket_id = aws_s3_bucket.alb_access_logs_bucket.id
}

module "encryption" {
    source    = "../modules/encryption/aes256"
    bucket_id = aws_s3_bucket.alb_access_logs_bucket.id
}

module "access" {
    source    = "../modules/access/public"
    bucket_id = aws_s3_bucket.alb_access_logs_bucket.id
}

module "lifecycle" {
    source    = "../modules/lifecycle/with_transitions"
    bucket_id = aws_s3_bucket.alb_access_logs_bucket.id
    rule_id   = "alb_access_logs_lifecycle"
    transition_days_glacier = 60
    days_after_initiation = 7
    transition_days_ia = 30
    expiration_days = 90
    noncurrent_days = 7
    prefix    = ""
}