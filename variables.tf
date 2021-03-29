variable "name" {
  type = string
}

variable "auto_public_ip" {
  type    = bool
  default = false
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ssh_public_key" {
  type = string
}

variable "ami_id" {
  type    = string
  default = null
}
# variable "read_dynamodb" { 
#   type = bool
#   default = false
# }

# variable "dynamodb_tables" { 
#   type = list(string)
# }