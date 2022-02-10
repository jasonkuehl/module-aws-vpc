# vpc-module
Another VPC Module

The module is made specifc for my needed for my personal amazon account.

Module Example

module "vpc" {
  source = "git@github.com:jasonkuehl/vpc-module.git?ref=vX.X.X"

  region                = us-east-2
  main_octet            = 150
  domain_settings_local = "yolo.fail"
  vpc-name              = "yolo-fail"
  public_subnet         = var.public_subnet
  private_subnet        = var.private_subnet
}

The subnets are setup as a map. Below you can find an example of use.
variable "public_subnet" {
  type = map(number)
 
  default = {
    "us-east-2a" = 1
    "us-east-2b" = 2
    "us-east-2c" = 3
  }
}

variable "private_subnet" {
  type = map(number)
 
  default = {
    "us-east-2a" = 10
    "us-east-2b" = 11
    "us-east-2c" = 12
  }
}