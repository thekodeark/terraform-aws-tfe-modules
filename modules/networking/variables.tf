# variables.tf | Auth and Application variables
variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC."
  default     = "10.10.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets"
  default     = ["10.10.100.0/24", "10.10.101.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets"
  default     = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}