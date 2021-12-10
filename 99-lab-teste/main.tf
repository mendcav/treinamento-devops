provider "aws" {
  region = "sa-east-1"
}

variable "qtde" {
  type = number
  #default      = 3  
  description = "Informar qtde de maquinas: "

  validation {
    condition     = var.qtde <= 5
    error_message = "Valor deve ser de 0 a 5."
  }
}

variable "image_id" {
  type        = string
  description = "Informar ami-"

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "O valor do image_id não é válido, tem que começar com \"ami-\"."
  }
}

variable "subnet_id" {
  type        = string
  description = "A subnet para ser usado no servidor. padrao subnet-1234"

  validation {
    condition     = length(var.subnet_id) > 7 && substr(var.subnet_id, 0, 7) == "subnet-"
    error_message = "O valor da subnet não é válido, tem que começar com \"subnet-\"."
  }
}

variable "instance_id" {
  type        = string
  description = "O instance type usado no servidor. Padrão t2.small"

  validation {
    condition     = length(var.instance_id) >= 4 && substr(var.instance_id, 0, 3) == "t2."
    error_message = "O tamanho não é válido, tem que começar com \"t2.[...]\"."
  }
}

variable "sg_id" {
  type        = string
  description = "Informar security group"

  validation {
    condition     = length(var.sg_id) >= 4 && substr(var.sg_id, 0, 3) == "sg-"
    error_message = "O nome do SG não é válido, tem que começar com \"sg-[...]\"."
  }
}


variable "name_id" {
  type        = string
  description = "O instance name usado no servidor. Padrão ec2-grupo5"

  validation {
    condition     = length(var.name_id) > 0
    error_message = "O nome não é válido, refaça."
  }
}


# output private_ip {
#   value       = aws_instance.web2[0].private_ip
# }


resource "aws_instance" "web2" {
  subnet_id                   = var.subnet_id
  ami                         = var.image_id
  instance_type               = var.instance_id
  key_name                    = "cert-turma3-mendcav-dev" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  root_block_device {
    encrypted   = true
    volume_size = 8
  }
  count = var.qtde
  tags = {
    #Name = var.name_id
    #Name = each.value
    Name = "${var.name_id}-${count.index}"
  }
   depends_on = [
     aws_security_group.allow_ssh
   ]
}

output "public_ip_dns" {
  value = [
    for web in aws_instance.web2 :
    <<EOF
     Public IP : ${web.public_ip} 
     Public DNS: ${web.public_dns}
     ssh -i /home/ubuntu/cert-turma3-mendcav-dev.pem ubuntu@${web.public_ip}
    EOF
  ]
}

data "http" "meuip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "allow_ssh" {
  name        = "libera_ssh_mendcav_tf_2"
  #name        = "Turma3-grupo5-sg-tf"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0def197fc853b3c38"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.meuip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups = null,
      self            = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups  = null,
      self             = null,
      description      = "Libera dados da rede interna"
    }
  ]
}





