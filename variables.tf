variable "vpc-name" {
  type        = string
  description = "Naming the VPC"
}

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
}

variable "private_subnet" {
  type = map(number)
}
