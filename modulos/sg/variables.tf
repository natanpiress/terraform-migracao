##variables security-group
variable "sgname" {
  description = "Name to be used the resources as identifier"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "environment" {
  description = "Env tags"
  type        = string
  default     = null
}

variable "rules_security_group" {
  description = "Rules security group"
  type        = any
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(any)
  default     = {}
}
