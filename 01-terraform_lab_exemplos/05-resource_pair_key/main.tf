provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  subnet_id = "subnet-0be7a57595540e840"
  ami = "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  key_name = "chave_key_mendcav_tf" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-05ef2a719830699e9"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-mendcav-tf"
  }
  # depends_on = [
  #   aws_key_pair.chave_key
  # ]
}

output dns {
  value       = aws_instance.web.public_dns
  description = "DNS para conexão: "
}

resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key_mendcav_tf"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4A8ZFj1i+CRlzEdUOrBfHWs+AtP42Fp7IOxy3NflEcWCD4V71zQc/V+WFDmSsbyWTHbeTVaHjZlxaU1ULs/86HyZur6PDAS9ScYmqltp8RtxWY842cbw7r5B9QfWN4zBMoGQBwMbuL3Z7vJQGfGiSRQb560gzBVV7EPlB90jGqp8ySF3vQUIqt0V+7/1g7MT2P37bYLdgu99sd2Yp9uqbkGt6XAcVqdFg2vHXAxd1wRQDTunmRvAh1uo0QA90kuyhlqa8G6AkVbgG889FUY2SA3r4C94Qb+OZIdJOwpxb9udWPjDchZkEtIzcPxKggMr/BzjjnhBl3oPxh0KZU6MMv2A2K0xS4Y/VOTqJQGXsk/fCqz1CnhwYcE6CZw86R1nATbFL3TBSMp41bA4ywEN/AZNvZ6apHqNX+H7f2ebvceO+Zl+dyr42j3qJUzYuViA4wECysG6NVhKNoIlnYQ6jFSJ+6VD7y/RWCpwALgDx0Q75Jxjq6LLqPImPmzF0aGk= ubuntu@mendcav-dev" # sua chave publica da maquina 
}