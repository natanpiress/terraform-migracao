resource "aws_autoscaling_group" "this" {
  count = var.asg_create ? 1 : 0

  availability_zones        = var.vpc_zone_identifier != [] ? var.availability_zones : []
  capacity_rebalance        = var.capacity_rebalance
  default_cooldown          = var.default_cooldown
  health_check_grace_period = var.health_check_grace_period
  metrics_granularity       = var.metrics_granularity
  desired_capacity          = var.desired_size
  health_check_type         = var.health_check_type
  max_size                  = var.max_size
  min_size                  = var.min_size
  name                      = format("%s-%s", var.name_asg, var.environment)

  dynamic "mixed_instances_policy" {
    for_each = var.use_mixed_instances_policy ? [var.mixed_instances_policy] : []
    content {
      dynamic "instances_distribution" {
        for_each = try([mixed_instances_policy.value.instances_distribution], [])
        content {
          on_demand_allocation_strategy            = try(instances_distribution.value.on_demand_allocation_strategy, null)
          on_demand_base_capacity                  = try(instances_distribution.value.on_demand_base_capacity, null)
          on_demand_percentage_above_base_capacity = try(instances_distribution.value.on_demand_percentage_above_base_capacity, null)
          spot_allocation_strategy                 = try(instances_distribution.value.spot_allocation_strategy, null)
          spot_instance_pools                      = try(instances_distribution.value.spot_instance_pools, null)
          spot_max_price                           = try(instances_distribution.value.spot_max_price, null)
        }
      }

      launch_template {
        launch_template_specification {
          launch_template_id = aws_launch_template.this[0].id
          version            = local.launch_template_version
        }

        dynamic "override" {
          for_each = try(mixed_instances_policy.value.override, [])
          content {
            instance_type = try(override.value.instance_type, {})
          }
        }
      }
    }
  }

  dynamic "launch_template" {
    for_each = var.use_mixed_instances_policy ? [] : [1]

    content {
      id      = aws_launch_template.this[0].id
      version = local.launch_template_version
    }
  }

  dynamic "tag" {
    for_each = var.asg_tags

    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch

    }
  }

  load_balancers       = var.load_balancers
  target_group_arns    = var.target_group_arns
  termination_policies = var.termination_policies

  vpc_zone_identifier = var.availability_zones != [] ? var.vpc_zone_identifier : []
}
