provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia_da_erika" {
  source = "git@github.com:mendcav/modulo_devops_terraform_mendcav.git"
  nome = "mendcav-terraform-modulo"
  tipo = "t2.nano"
}