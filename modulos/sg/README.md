# security-group-aws-terraform

Terraform module create security group aws

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.9 |

## Usage

```hcl
module "sg" {
  source      = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules//sg"
  sgname      = "sgtest"
  environment = "hml"
  vpc_id      = "vpc-abcabcabc"

  rules_security_group = {
    
    ## Rule ingress cidr_block
    ingress_rule_1 = {
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      type        = "ingress"
      cidr_blocks = ["172.31.0.0/16"]
    }
    
    ## Rule ingress source_security
    ingress_rule_2 = {
      from_port                = 6379
      to_port                  = 6379
      protocol                 = "tcp"
      type                     = "ingress"
      source_security_group_id = "sg-abcabcabc"
    }
    
    ## Rule ingress all traffic cidr_block
    ingress_rule_3 = {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      type        = "ingress"
      cidr_blocks = ["10.11.10.0/16"]
    }
  }

  tags = {
    Environment = "hml"
  }

}
```

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Env tags | `string` | `null` | no |
| <a name="input_rules_security_group"></a> [rules\_security\_group](#input\_rules\_security\_group) | Rules security group | `any` | `{}` | no |
| <a name="input_sgname"></a> [sgname](#input\_sgname) | Name to be used the resources as identifier | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | The ID of the security group |
| <a name="output_sg_name"></a> [sg\_name](#output\_sg\_name) | Output security group name |
