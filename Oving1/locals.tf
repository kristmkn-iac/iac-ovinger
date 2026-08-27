locals {
  company = var.company
  project = "${var.company}-${var.project}"

  common_tags = {
    Owner       = var.owner
    CostCenter  = var.billing_code
    Environment = "test"
    Project     = local.project
  }
}

locals {
  prefix = var.prefix
}