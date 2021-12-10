resource "aws_key_pair" "chave_key_mendcav" {
  key_name   = "chave_key"
 public_key = var.ssh_pub_key
}
