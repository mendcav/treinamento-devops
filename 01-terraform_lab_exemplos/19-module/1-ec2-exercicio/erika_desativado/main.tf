terraform {
  required_version = ">= 0.12" # colocando compatibilidade do terraform para 0.12
}

resource "aws_instance" "web" {
  ami = "ami-0e66f5495b4efdd0f"
  subnet_id = "subnet-0be7a57595540e840"
  #count = 2 # cria mais de uma
  instance_type = var.tipo
  key_name = "cert-turma3-mendcav-dev" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-05ef2a719830699e9"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}",
    Itau = true
  }
}

# image_id    = "ami-0e66f5495b4efdd0f"
# instance_id = "t2.micro"
# name_id     = "ec2-grupo5-teste"
# qtde        = "3"
# sg_id       = "sg-05ef2a719830699e9"
# subnet_id   = "subnet-0be7a57595540e840"
# cert-turma3-mendcav-dev
