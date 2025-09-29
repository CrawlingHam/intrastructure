module "access" {
    source = "./access"

    bucket_id = var.bucket_id
}

module "encryption" {
    source = "./encryption"

    bucket_id = var.bucket_id
}

module "versioning" {
    source = "./versioning"

    bucket_id = var.bucket_id
}