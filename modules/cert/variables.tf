# variables.tf | Auth and Application variables

variable "hosted_zone" {
  type = string
}

variable "fqdn" {
  type        = string
  description = "Fully qualified domain name"
}