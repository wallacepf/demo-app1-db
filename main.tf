terraform {
  required_providers {
    aws = {
      version = "~>3.0"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend  = "remote"
  hostname = "app.terraform.io"
  config = {
    organization = "myterraformcloud"
    workspaces = {
      name = "app1-network"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "random" {
  length  = 8
  upper   = false
  special = false
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~>2.0"

  identifier = "demodb-${random_string.random.id}"

  engine         = "postgres"
  engine_version = "12.5"
  family         = "postgres12"
  instance_class = var.db_instance_type

  allocated_storage     = 20
  max_allocated_storage = 100

  name     = "mydb"
  username = "postgres"
  password = "mysafepwd"
  port     = 5432

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  subnet_ids             = data.terraform_remote_state.vpc.outputs.subnets
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]

}
