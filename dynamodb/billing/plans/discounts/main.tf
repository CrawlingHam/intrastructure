resource "aws_dynamodb_table" "discounts" {
    name           = "${var.project_name}-plan-discounts-${var.environment}"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "discount_id"
    range_key      = "plan_id"

    # Primary Key
    attribute {
        name = "discount_id"
        type = "S"
    }

    # Range Key
    attribute {
        name = "plan_id"
        type = "S"
    }

    ttl {
        attribute_name = "expires_at"
        enabled        = true
    }

    point_in_time_recovery {
        enabled = true
    }

    server_side_encryption {
        enabled = true
    }

    tags = merge(var.common_tags, {
        Name    = "${var.project_name}-plan-discounts-${var.environment}"
        Purpose = "Billing Plan Discounts Management"
        Table   = "plan-discounts"
    })
}