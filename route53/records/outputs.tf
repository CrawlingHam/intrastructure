output "frontend_alb_a_record_id" {
    value = aws_route53_record.frontend_alb_a_record.id
}

output "backend_alb_a_record_id" {
    value = aws_route53_record.backend_alb_a_record.id
}