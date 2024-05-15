variable "rbac" {
  description = "Map rbac configuration"
  type        = any
  default     = {}
}

variable "nodes" {
  description = "Custom controller ebs a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "version_alb" {
  description = "Version used helm ALB"
  type        = string
  default     = "v2.5.4"
}

variable "domain" {
  description = "Domain used helm External dns"
  type        = string
  default     = ""
}

variable "filesystem_id" {
  description = "Filesystem used helm efs"
  type        = string
  default     = "fs-92107410"
}

variable "custom_helm" {
  description = "Custom a Release is an instance of a chart running in a Kubernetes cluster."
  type        = map(any)
  default     = {}
}

variable "custom_values_efs" {
  description = "Custom controler efs a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "custom_values_elastic" {
  description = "Custom controler elastic a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "custom_values_alb" {
  description = "Custom controler alb a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "custom_values_ebs" {
  description = "Custom controller ebs a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "custom_values_asg" {
  description = "Custom controller asg a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "custom_values_external-dns" {
  description = "Custom external-dns a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "custom_values_metrics-server" {
  description = "Custom metrics-server a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "elasticsearch" {
  description = "Install release helm controller elastic"
  type        = bool
  default     = false
}

variable "aws-efs-csi-driver" {
  description = "Install release helm controller efs"
  type        = bool
  default     = false
}

variable "aws-ebs-csi-driver" {
  description = "Install release helm controller ebs"
  type        = bool
  default     = false
}

variable "aws-load-balancer-controller" {
  description = "Install release helm controller alb"
  type        = bool
  default     = false
}

variable "external-dns" {
  description = "Install release helm external"
  type        = bool
  default     = false
}

variable "metrics-server" {
  description = "Install release helm metrics-server"
  type        = bool
  default     = false
}

variable "aws-autoscaler-controller" {
  description = "Install release helm controller asg"
  type        = bool
  default     = false
}

variable "private_subnet" {
  description = "List subnet nodes"
  type        = list(any)
  default     = []
}
## Clusters

variable "environment" {
  description = "Env tags"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "node-role" {
  description = "Role node"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "Name cluster"
  type        = string
  default     = null
}

variable "master-role" {
  description = "Role master"
  type        = string
  default     = ""
}

variable "kubernetes_version" {
  description = "Version kubernetes"
  type        = string
  default     = "1.23"
}

variable "endpoint_public_access" {
  description = "Endpoint access public"
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Endpoint access private"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "Security group ids"
  type        = list(any)
  default     = []
}

variable "subnet_ids" {
  description = "Subnet private"
  type        = list(any)
  default     = []
}

variable "enabled_cluster_log_types" {
  description = "List of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging."
  type        = list(string)
  default     = []
}

variable "create_ebs" {
  description = "Install addons ebs"
  type        = bool
  default     = false
}

variable "create_core" {
  description = "Install addons core"
  type        = bool
  default     = false
}

variable "create_vpc_cni" {
  description = "Install addons vpc_cni"
  type        = bool
  default     = false
}

variable "create_proxy" {
  description = "Install addons proxy"
  type        = bool
  default     = false
}

variable "mapRoles" {
  description = "List of role maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "mapUsers" {
  description = "List of user maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "mapAccounts" {
  description = "List of accounts maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "create_aws_auth_configmap" {
  description = "Create configmap aws-auth"
  type        = bool
  default     = false
}

variable "manage_aws_auth_configmap" {
  description = "Manager configmap aws-auth"
  type        = bool
  default     = true
}

variable "fargate_auth" {
  description = "Auth role fargate profile"
  type        = bool
  default     = false
}

# variable "rbac" {
#   description = "Map rbac configuration"
#   type        = any
#   default     = {}
# }

variable "velero" {
  description = "Install release helm velero "
  type        = bool
  default     = false
}

variable "custom_values_velero" {
  description = "Custom velero a Release is an instance of a chart running in a Kubernetes cluster"
  type        = any
  default     = {}
}

variable "force_destroy" {
  description = "Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "ingress-nginx" {
  description = "Install release helm controller ingress-nginx"
  type        = bool
  default     = false
}

variable "cert-manager" {
  description = "Install release helm controller cert-manager"
  type        = bool
  default     = false
}