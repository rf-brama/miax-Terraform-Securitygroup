output "dbsecurity_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.DB-Security-Group.id
}

output "Open_Security_Group" {
  description = "The ID of the security group"
  value       = aws_security_group.Open-Security-Group.id
}

output "kafka_security_group" {
  description = "The ID of the security group"
  value       = aws_security_group.kafka.id
}

/* output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.security_group_vpc_id
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = module.security_group_owner_id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.security_group_name
}

output "security_group_description" {
  description = "The description of the security group"
  value       = module.security_group_description
} */
