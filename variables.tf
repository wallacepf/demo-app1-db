variable "common_tags" {
  type = map(string)
}

variable "aws_region" {
  default = "us-west-2"
}

variable "db_instance_type" {
  default = "db.t2.micro"
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_pwd" {
  type      = string
  sensitive = true
}
