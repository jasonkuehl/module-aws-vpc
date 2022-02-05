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
