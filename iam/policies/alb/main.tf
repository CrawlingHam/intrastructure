resource "aws_s3_bucket_policy" "alb_access_logs_bucket" {
    bucket = var.alb_access_logs_bucket_id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid    = "AWSLogDeliveryWrite"
                Effect = "Allow"
                Principal = {
                    Service = "logdelivery.elasticloadbalancing.amazonaws.com"
                }
                Action   = "s3:PutObject"
                Resource = "${var.alb_access_logs_bucket_arn}/*"
                Condition = {
                    StringEquals = {
                        "s3:x-amz-acl" = "bucket-owner-full-control"
                    }
                }
            },
            {
                Sid    = "AWSLogDeliveryAclCheck"
                Effect = "Allow"
                Principal = {
                    Service = "logdelivery.elasticloadbalancing.amazonaws.com"
                }
                Action   = "s3:GetBucketAcl"
                Resource = var.alb_access_logs_bucket_arn
            }
        ]
    })
}