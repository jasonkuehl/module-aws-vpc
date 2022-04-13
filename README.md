[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=jasonkuehl_terraform-aws-vpc&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=jasonkuehl_terraform-aws-vpc)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=jasonkuehl_terraform-aws-vpc&metric=reliability_rating)](https://sonarcloud.io/summary/new_code?id=jasonkuehl_terraform-aws-vpc)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=jasonkuehl_terraform-aws-vpc&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=jasonkuehl_terraform-aws-vpc)

# vpc-module
Another VPC Module

The module is made specifc for my needed for my personal amazon account.

- Sets up the route tables for the public and private subnets you specify.
- IPV6 Enabled by default
- enable_dns_hostnames is enabled
- enable_dns_support  is enabled
- Creates up an internet gateway and route table for your public subnets.
- Creates an egress only internet gateway for IPv6 traffic outbound from the private subnets.


Module Example

```module "vpc" {
  source = "git@github.com:jasonkuehl/vpc-module.git?ref=vX.X.X"

  region                = us-east-2
  main_octet            = 150
  domain_settings_local = "yolo.fail"
  vpc-name              = "yolo-fail"
  public_subnet         = var.public_subnet
  private_subnet        = var.private_subnet
}
```

Im using a subnet map based on the region and setting an octet for each. This is accessible from the outputs.
```
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
````
