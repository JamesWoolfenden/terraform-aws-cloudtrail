provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      createdby = "Terraform"
    module = "terraform-aws-cloudtrail" }
  }
}
