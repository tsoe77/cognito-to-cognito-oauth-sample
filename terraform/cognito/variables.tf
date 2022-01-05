variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "app1_user_pool_name" {
  description = "name of the app1 user pool"
  type        = string
}

variable "app1_domain_name" {
  description = "app1 domain name"
  type        = string
}
variable "app2_user_pool_name" {
  description = "name of the app1 user pool"
  type        = string
}

variable "app2_domain_name" {
  description = "app2 domain name"
  type        = string
}

variable "provider_name" {
  description = "identity provider name"
  type        = string
}

variable "provider_type" {
  description = "identity provider type"
  type        = string
}
