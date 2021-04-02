variable "common_tags" {
  type = map(string)
}

variable "aws_region" {
  default = "us-west-2"
}

variable "db_instance_type" {
  default = "db.t2.micro"
}

