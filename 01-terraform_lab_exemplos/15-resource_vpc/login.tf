terraform {
  backend "remote" {
    organization = "mendcav-corp"

    workspaces {
      name = "modulo-terraform-mendcav"
    }
  }
}