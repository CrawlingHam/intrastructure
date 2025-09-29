resource "aws_s3_bucket" "terraform_state_bucket" {
    bucket = "${var.project_name}-terraform-state-${var.environment}-${var.region}"
    
    tags = merge(var.common_tags, {
        Name    = "${var.project_name}-terraform-state-${var.environment}-${var.region}"
        Purpose = "Terraform State Storage"
        Region  = var.region
    })
}

module "versioning" {
    source = "../../modules/versioning"
    bucket_id = aws_s3_bucket.terraform_state_bucket.id
}

module "encryption" {
    source = "../../modules/encryption/aes256"
    bucket_id = aws_s3_bucket.terraform_state_bucket.id
}

module "access" {
    source = "../../modules/access/public"
    bucket_id = aws_s3_bucket.terraform_state_bucket.id
}

module "lifecycle" {
    bucket_id = aws_s3_bucket.terraform_state_bucket.id
    source = "../../modules/lifecycle/basic"
    rule_id = "terraform_state_lifecycle"
    days_after_initiation = 7
    noncurrent_days = 30
    prefix = ""
}
