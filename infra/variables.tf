#Define AWS Region
variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-2"
}
variable "name" {
  description = "The name of the application."
  type        = string
  default     = "app-14"
}
variable "vpc_cidr" {
  description = "the vpc cidr"
  default     = "10.20.20.0/26"
}
variable "subnet_cidr_public" {
  description = "cidr blocks for the public subnets"
  default     = ["10.20.20.0/27", "10.20.20.32/27"]
  type        = list(any)
}