/*variable "instance_name" {
  default     = {
    ec2_grupo5_marcelo = "subnet-03570fb137882b7d3",
    ec2_grupo5_michelle = "subnet-0842414f901483088",
    ec2_grupo5_roberto = "subnet-04157a234e4e8ddce",
    ec2_grupo5_minero = "subnet-0af3888a094ba00f9"
  }
}*/

provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "instances" {
  for_each = var.instance_name
  subnet_id = each.value
  ami = "ami-0e66f5495b4efdd0f"
  #count = length(keys(var.instance_name))
  instance_type = "t3.micro"
  key_name = "cert-turma3-mendcav-dev" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-00b4800cc931fe9d0"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = each.key
  }
}

variable "image_id" {
  type        = string
  description = "O id do Amazon Machine Image (AMI) deve ser ami-1234."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "O valor do image_id não é válido, tem que começar com \"ami-\"."
  }
}
output "image_id" {
    value = var.image_id
}

variable "subnet_id" {
  type        = string
  description = "A subnet para ser usado no servidor. padrao subnet-1234"

  validation {
    condition     = length(var.subnet_id) > 7 && substr(var.subnet_id, 0, 7) == "subnet-"
    error_message = "O valor da subnet não é válido, tem que começar com \"subnet-\"."
  }
}
output "subnet_id" {
    value = var.subnet_id
}

variable "tamanho_id" {
  type        = string
  description = "O instance type usado no servidor. Padrão t2.small"

  validation {
    condition     = length(var.tamanho_id) > 3 && substr(var.tamanho_id, 0, 3) == "t2."
    error_message = "O tamanho não é válido, tem que começar com \"t2.\"."
  }
}
output "tamanho_id" {
    value = var.tamanho_id
}

variable "name_id" {
  type        = string
  description = "O instance name usado no servidor. Padrão ec2-grupo5"

  validation {
    condition     = length(var.name_id) > 0
    error_message = "O nome não é válido, refaça."
  }
}

output "name_id" {
    value = var.name_id
}

