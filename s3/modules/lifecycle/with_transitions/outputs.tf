output "lifecycle_id" {
    value       = aws_s3_bucket_lifecycle_configuration.with_transitions.bucket
}