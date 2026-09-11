resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  iam_instance_profile = var.iam_instance_profile

  user_data_replace_on_change = true

  user_data = <<-EOF
#!/bin/bash

apt-get update -y
apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
  <title>Terraform DevOps Project</title>
</head>
<body>
  <h1>Terraform AWS Project</h1>
  <p>EC2 provisioned and configured using Terraform.</p>
  <p>Nginx installed automatically using Terraform User Data.</p>
</body>
</html>
HTML
EOF

  tags = {
    Name        = "terraform-web-server"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Role        = "WebServer"
  }
}
resource "aws_eip" "web" {
  domain = "vpc"

  tags = {
    Name        = "terraform-web-eip"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_eip_association" "web" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web.id
}