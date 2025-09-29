resource "aws_dynamodb_table" "terraform_state_lock" {
    name           = "${var.project_name}-terraform-state-lock-${var.environment}-${var.region}"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = merge(var.common_tags, {
        Name    = "${var.project_name}-terraform-state-lock-${var.environment}-${var.region}"
        Purpose = "Terraform State Locking"
        Region  = var.region
    })
}
