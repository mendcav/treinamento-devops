variable "qtde" {
  type = number
  #default      = 3  
  description = "Informar qtde de maquinas: "

  validation {
    condition     = var.qtde <= 5
    error_message = "Valor deve ser de 0 a 5."
  }
}

variable "instance_type" {
  type        = string
  description = "O instance type usado no servidor. Padrão t2.small"

  validation {
    condition     = length(var.instance_type) >= 4 && substr(var.instance_type, 0, 3) == "t2."
    error_message = "O tamanho não é válido, tem que começar com \"t2.[...]\"."
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

variable ssh_pub_key {
  type        = string
  description = "chave publica ssh"
}
