variable "addons" {
  type    = map(any)
  default = {}
}

variable "eks_cluster_id" {
  type    = string
  default = ""
}

variable "openid_connect" {
  type    = string
  default = ""
}

variable "openid_url" {
  type    = string
  default = ""
}

variable "cluster_version" {
  type    = string
  default = "1.23"
}
