output "private_ids" {
  description = "Output subnet private"
  value       = aws_subnet.private.*.id
}

output "private_cidrs" {
  description = "Output subnet private"
  value       = aws_subnet.private.*.cidr_block
}

output "public_ids" {
  description = "Output subnet public"
  value       = aws_subnet.public.*.id
}

output "public_cidrs" {
  description = "Output subnet public"
  value       = aws_subnet.public.*.cidr_block
}

output "vpc_id" {
  description = "Output vpc id"
  value       = aws_vpc.this.id
}

output "vpc_name" {
  description = "Output vpc name"
  value       = aws_vpc.this.tags.Name
}

output "vpc_cidr" {
  description = "Output vpc cidr"
  value       = aws_vpc.this.cidr_block
}


output "igw" {
  description = "Output vpc cidr"
  value       = aws_internet_gateway.this.id
}

output "nat" {
  description = "Output vpc cidr"
  value       = aws_nat_gateway.this.id
}
