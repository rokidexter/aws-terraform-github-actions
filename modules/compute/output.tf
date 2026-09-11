output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.web.private_ip
}

output "public_ip" {
  description = "Elastic IP address of the EC2 instance"
  value       = aws_eip.web.public_ip
}

output "eip_allocation_id" {
  description = "Elastic IP allocation ID"
  value       = aws_eip.web.id
}