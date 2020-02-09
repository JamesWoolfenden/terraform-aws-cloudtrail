module "cloudtrail" {
  source      = "../../"
  common_tags = var.common_tags
  trail       = var.trail
}
