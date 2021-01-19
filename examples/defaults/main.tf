variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

resource "random_pet" "name" {
  length = 2
}

variable "private_key_path" {}
variable "public_key_path" {}

module "defaults" {
  source           = "../.."
  name             = "btcpool-${random_pet.name.id}"
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
}

output "public_ip" {
  value = module.defaults.public_ip
}