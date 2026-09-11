terraform {
  backend "s3" {
    bucket       = "terraform-aws-project-state-382170164329"
    key          = "terraform-aws-project/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}