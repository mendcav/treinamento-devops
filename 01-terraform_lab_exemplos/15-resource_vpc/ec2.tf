#aws_vpc.main.id
#aws_subnet.my_subnet_a.id

resource "aws_instance" "web2" {
  subnet_id                   = aws_subnet.my_subnet_a.id
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.chave_key_mendcav.key_name
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
     ssh -i id_rsa ubuntu@${web.public_ip}
    EOF
  ]
}

data "http" "meuip" {
  url = "http://ipv4.icanhazip.com"
}






