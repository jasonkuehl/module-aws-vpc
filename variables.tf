variable "vpc-name" {
  type        = string
  description = "Naming the VPC"
}

#starting number is 10
variable "main_octet" {
  type        = string
  description = "Second onctet for the vpc"
}


variable "domain_settings_local" {
  type        = string
  description = "domain_settings_local additon"
}

variable "region" {
  type        = string
  description = "region"
}

variable "public_subnet" {
  type = map(number)
 
  description = "Map of AZ to a number that should be used for public subnets"
 
  default = {
    "us-east-2a" = 1
    "us-east-2b" = 2
    "us-east-2c" = 3
  }
}

variable "private_subnet" {
  type = map(number)
 
  description = "Map of AZ to a number that should be used for private subnets"
 
  default = {
    "us-east-2a" = 10
    "us-east-2b" = 11
    "us-east-2c" = 12
  }
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.150.0.0/16"
}