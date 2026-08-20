# holden:ignore:HLD_TF_026: in-repo example, calls the module under test by relative path
module "cloudtrail" {
  source = "../../"
  trail  = var.trail
}
