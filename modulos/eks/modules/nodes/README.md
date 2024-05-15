## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_eks_fargate_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_node_group.eks_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSFargatePodExecutionRolePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.eks-worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_create"></a> [asg\_create](#input\_asg\_create) | Create asg group | `bool` | `false` | no |
| <a name="input_asg_tags"></a> [asg\_tags](#input\_asg\_tags) | Configuration block(s) containing resource tags | `any` | `[]` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of one or more availability zones for the group. Used for EC2-Classic and default subnets when not specified with `vpc_zone_identifier` argument. Conflicts with `vpc_zone_identifier` | `list(string)` | `null` | no |
| <a name="input_capacity_rebalance"></a> [capacity\_rebalance](#input\_capacity\_rebalance) | Whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled. | `bool` | `false` | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Type of capacity associated with the EKS Node Group. Valid values: ON\_DEMAND, SPOT | `string` | `"ON_DEMAND"` | no |
| <a name="input_certificate_authority"></a> [certificate\_authority](#input\_certificate\_authority) | Certificate authority cluster | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name cluster | `string` | `null` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version cluster | `string` | `""` | no |
| <a name="input_create_fargate"></a> [create\_fargate](#input\_create\_fargate) | Create fargate profile | `bool` | `false` | no |
| <a name="input_create_node"></a> [create\_node](#input\_create\_node) | Create node-group | `bool` | `true` | no |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | Amount of time, in seconds, after a scaling activity completes before another scaling activity can start. | `number` | `null` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Numbers desired nodes | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size disk node-group | `number` | `20` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Endpoint cluster | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Env tags | `string` | `null` | no |
| <a name="input_fargate_profile_name"></a> [fargate\_profile\_name](#input\_fargate\_profile\_name) | Name of the EKS Fargate Profile | `string` | `""` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | Time (in seconds) after instance comes into service before checking health. | `number` | `300` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | EC2 or ELB. Controls how health checking is done. | `string` | `"EC2"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | he IAM Instance Profile to launch the instance with | `string` | `null` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Type instances | `list(string)` | <pre>[<br>  "t3.micro"<br>]</pre> | no |
| <a name="input_instance_types_launch"></a> [instance\_types\_launch](#input\_instance\_types\_launch) | Type instances | `string` | `"t3.micro"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed | `map(string)` | `null` | no |
| <a name="input_labels_lt"></a> [labels\_lt](#input\_labels\_lt) | Labels to be applied to the launch template | `string` | `""` | no |
| <a name="input_launch_create"></a> [launch\_create](#input\_launch\_create) | Create launch | `bool` | `false` | no |
| <a name="input_launch_template_id"></a> [launch\_template\_id](#input\_launch\_template\_id) | The ID of an existing launch template to use. Required when `create_launch_template` = `false` and `use_custom_launch_template` = `true` | `string` | `""` | no |
| <a name="input_launch_template_version"></a> [launch\_template\_version](#input\_launch\_template\_version) | Launch template version number. The default is `$Default` | `string` | `null` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | List of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use target\_group\_arns instead. | `list(string)` | `[]` | no |
| <a name="input_max-pods"></a> [max-pods](#input\_max-pods) | n/a | `number` | `17` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Numbers max\_size | `number` | `2` | no |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | Granularity to associate with the metrics to collect. The only valid value is 1Minute | `string` | `"1Minute"` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Numbers min\_size | `number` | `1` | no |
| <a name="input_mixed_instances_policy"></a> [mixed\_instances\_policy](#input\_mixed\_instances\_policy) | Configuration block containing settings to define launch targets for Auto Scaling groups | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name launch configuration | `string` | `""` | no |
| <a name="input_name_asg"></a> [name\_asg](#input\_name\_asg) | Name of the Auto Scaling Group | `string` | `""` | no |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | Customize network interfaces to be attached at instance boot time | `any` | `[]` | no |
| <a name="input_node-role"></a> [node-role](#input\_node-role) | Role node | `string` | `""` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Name node | `string` | `null` | no |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | Subnet private | `list(any)` | `[]` | no |
| <a name="input_selectors"></a> [selectors](#input\_selectors) | Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile | `any` | `[]` | no |
| <a name="input_tag_specifications"></a> [tag\_specifications](#input\_tag\_specifications) | The tags to apply to the resources during launch | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_taints"></a> [taints](#input\_taints) | The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group | `any` | `{}` | no |
| <a name="input_taints_lt"></a> [taints\_lt](#input\_taints\_lt) | Taints to be applied to the launch template | `string` | `""` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | Set of aws\_alb\_target\_group ARNs, for use with Application or Network Load Balancing. | `list(string)` | `[]` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, Default | `list(string)` | <pre>[<br>  "OldestInstance"<br>]</pre> | no |
| <a name="input_use-max-pods"></a> [use-max-pods](#input\_use-max-pods) | n/a | `bool` | `false` | no |
| <a name="input_use_mixed_instances_policy"></a> [use\_mixed\_instances\_policy](#input\_use\_mixed\_instances\_policy) | Determines whether to use a mixed instances policy in the autoscaling group or not | `bool` | `false` | no |
| <a name="input_volume-size"></a> [volume-size](#input\_volume-size) | Size volume ebs | `string` | `""` | no |
| <a name="input_volume-type"></a> [volume-type](#input\_volume-type) | Type volume ebs | `string` | `""` | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside | `list(string)` | `null` | no |

## Outputs

No outputs.
