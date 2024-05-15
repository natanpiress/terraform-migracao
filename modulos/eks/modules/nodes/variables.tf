variable "max-pods" {
  type    = number
  default = 17
}

variable "use-max-pods" {
  type    = bool
  default = false
}

variable "taints_lt" {
  description = "Taints to be applied to the launch template"
  type        = string
  #--register-with-taints="dedicated=${local.environment}:NoSchedule"
  default = ""
}

variable "labels_lt" {
  description = "Labels to be applied to the launch template"
  type        = string
  #--node-labels="eks.amazonaws.com/nodegroup=${var.name_asg}"
  default = ""
}

variable "taints" {
  description = "The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group"
  type        = any
  default     = {}
}

variable "labels" {
  description = "Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  type        = map(string)
  default     = null
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "cluster_version_manager" {
  description = "Version cluster"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name cluster"
  type        = string
  default     = null
}

variable "node_name" {
  description = "Name node"
  type        = string
  default     = null
}

variable "launch_create" {
  description = "Create launch"
  type        = bool
  default     = false
}

variable "launch_template_id" {
  description = "The ID of an existing launch template to use. Required when `create_launch_template` = `false` and `use_custom_launch_template` = `true`"
  type        = string
  default     = ""
}

variable "launch_template_version" {
  description = "Launch template version number. The default is `$Default`"
  type        = string
  default     = null
}

variable "create_node" {
  description = "Create node-group"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Size disk node-group"
  type        = number
  default     = 20
}

variable "cluster_version" {
  description = "Version cluster"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Env tags"
  type        = string
  default     = null
}

variable "node-role" {
  description = "Role node"
  type        = string
  default     = ""
}

variable "instance_types" {
  description = "Type instances"
  type        = list(string)
  default     = ["t3.micro"]
}

variable "instance_types_launch" {
  description = "Type instances"
  type        = string
  default     = "t3.micro"
}

variable "private_subnet" {
  description = "Subnet private"
  type        = list(any)
  default     = []
}

variable "desired_size" {
  description = "Numbers desired nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Numbers max_size"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Numbers min_size"
  type        = number
  default     = 1
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name launch configuration"
  type        = string
  default     = ""
}


variable "tag_specifications" {
  description = "The tags to apply to the resources during launch"
  type        = any
  default     = []
}

variable "volume-size" {
  description = "Size volume ebs"
  type        = string
  default     = ""
}

variable "volume-type" {
  description = "Type volume ebs"
  type        = string
  default     = ""
}

variable "endpoint" {
  description = "Endpoint cluster"
  type        = string
  default     = ""
}

variable "certificate_authority" {
  description = "Certificate authority cluster"
  type        = string
  default     = ""
}

## Fargate profile

variable "create_fargate" {
  description = "Create fargate profile"
  type        = bool
  default     = false

}

variable "fargate_profile_name" {
  description = "Name of the EKS Fargate Profile"
  type        = string
  default     = ""
}

variable "selectors" {
  description = "Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile"
  type        = any
  default     = []
}


## ASG
variable "health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done."
  type        = string
  default     = "EC2"
}

variable "asg_create" {
  description = "Create asg group"
  type        = bool
  default     = false
}

variable "name_asg" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = ""
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside"
  type        = list(string)
  default     = null
}

variable "target_group_arns" {
  description = "Set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing."
  type        = list(string)
  default     = []
}

variable "load_balancers" {
  description = "List of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use target_group_arns instead."
  type        = list(string)
  default     = []
}

variable "asg_tags" {
  description = "Configuration block(s) containing resource tags"
  type        = any
  default     = []
}

variable "termination_policies" {
  description = "list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, Default"
  type        = list(string)
  default     = ["OldestInstance"]
}

variable "use_mixed_instances_policy" {
  description = "Determines whether to use a mixed instances policy in the autoscaling group or not"
  type        = bool
  default     = false
}

variable "mixed_instances_policy" {
  description = "Configuration block containing settings to define launch targets for Auto Scaling groups"
  type        = any
  default     = null
}

variable "availability_zones" {
  description = "A list of one or more availability zones for the group. Used for EC2-Classic and default subnets when not specified with `vpc_zone_identifier` argument. Conflicts with `vpc_zone_identifier`"
  type        = list(string)
  default     = null
}

variable "capacity_rebalance" {
  description = "Whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled."
  type        = bool
  default     = false

}

variable "default_cooldown" {
  description = " Amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
  type        = number
  default     = null
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health."
  type        = number
  default     = 300
}

variable "metrics_granularity" {
  description = "Granularity to associate with the metrics to collect. The only valid value is 1Minute"
  type        = string
  default     = "1Minute"
}


variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = any
  default     = []
}

variable "iam_instance_profile" {
  description = "he IAM Instance Profile to launch the instance with"
  type        = string
  default     = null
}

variable "pod_execution_role_arn" {
  type    = string
  default = ""
}