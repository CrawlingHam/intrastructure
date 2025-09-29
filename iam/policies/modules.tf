module "alb" {
    alb_access_logs_bucket_arn = var.alb_access_logs_bucket_arn
    alb_access_logs_bucket_id = var.alb_access_logs_bucket_id
    source = "./alb"
}