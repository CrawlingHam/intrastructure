output "alb_access_logs_bucket_policy_id" {
    value = aws_s3_bucket_policy.alb_access_logs_bucket.id
}