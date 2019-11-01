terraform {
  backend "remote" {
    organization = "bendrucker"
    workspaces {
      name = "aws-demo"
    }
  }
}