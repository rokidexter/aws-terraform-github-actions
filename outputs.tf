output "vpc_id" {
  description = "ID of the Terraform project VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = [
    module.networking.public_subnet_a_id,
    module.networking.public_subnet_b_id
  ]
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.networking.security_group_id
}

output "ec2_instance_id" {
  description = "ID of the web EC2 instance"
  value       = module.compute.instance_id
}

output "ec2_private_ip" {
  description = "Private IP address of the web EC2 instance"
  value       = module.compute.private_ip
}

output "ec2_public_ip" {
  description = "Elastic IP associated with the web EC2 instance"
  value       = module.compute.public_ip
}

output "application_url" {
  description = "URL for accessing the web server"
  value       = "http://${module.compute.public_ip}"
}

output "s3_bucket_name" {
  description = "Name of the Terraform-managed S3 bucket"
  value       = aws_s3_bucket.project.id
}

output "iam_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2.name
}

output "iam_instance_profile_name" {
  description = "Name of the EC2 IAM instance profile"
  value       = aws_iam_instance_profile.ec2.name
}

