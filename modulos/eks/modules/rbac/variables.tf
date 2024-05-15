variable "rules" {
  description = "The Role to bind Subjects to"
  type        = any
}

variable "subjects" {
  description = "The Users, Groups, or ServiceAccounts to grand permissions to"
  type        = any
}

variable "metadata" {
  description = "Standard kubernetes metadata"
  type        = any
}

variable "service-account-create" {
  description = "Create service account"
  type        = bool
  default     = false
}