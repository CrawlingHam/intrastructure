output "alb_access_logs_bucket_id" {
    value       = aws_s3_bucket.alb_access_logs_bucket.id
}

output "alb_access_logs_bucket_arn" {
    value       = aws_s3_bucket.alb_access_logs_bucket.arn
}

output "alb_access_logs_bucket_name" {
    value       = aws_s3_bucket.alb_access_logs_bucket.bucket
}
