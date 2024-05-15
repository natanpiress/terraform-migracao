locals {
  environment = "staging"
  tags = {
    Environment = "staging"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

module "vpc" {
  source = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules//vpc"

  name                 = "my-vpc"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags        = local.tags
  environment = local.environment

  private_subnets         = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  map_public_ip_on_launch = true

  igwname = "my-igw"
  natname = "my-nat"
  rtname  = "my-rt"

  create_aws_flow_log = true
}

module "iam" {
  source = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules//iam"

  create_role = true

  rolename           = "role-logflow-${local.environment}"
  policyname         = "policy-logflow-${local.environment}"
  assume_role_policy = local.assume_role_policy
  policy             = local.policy

  tags = local.tags
}

module "log-group" {
  source = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules//log_group"

  lognames    = "vpc-logflow-group-${local.environment}"
  environment = local.environment

}
