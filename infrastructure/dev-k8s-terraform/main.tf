provider "aws" {
  region = "us-east-1"
}

# Variable name: use underscores, not hyphens
variable "sec_gr_k8s" {
  default = "event-service-k8s-sec-group"
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group for Kubernetes
resource "aws_security_group" "k8s_sec_gr" {
  name   = var.sec_gr_k8s
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = var.sec_gr_k8s
  }

  ingress {
    description = "Allow all internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider restricting this for security
  }

  ingress {
    description = "Kubernetes API Server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role for EC2
resource "aws_iam_role" "event_service_master_server_s3_role" {
  name               = "event-service-master-server-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach S3 ReadOnly policy to the role
resource "aws_iam_role_policy_attachment" "event_service_s3_policy" {
  role       = aws_iam_role.event_service_master_server_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Instance Profile for EC2
resource "aws_iam_instance_profile" "event_service_master_server_profile" {
  name = "event-service-master-server-profile"
  role = aws_iam_role.event_service_master_server_s3_role.name
}

# Master Node
resource "aws_instance" "kube_master" {
  ami                    = "ami-005fc0f236362e99f"
  instance_type          = "t3a.medium"
  iam_instance_profile   = aws_iam_instance_profile.event_service_master_server_profile.name
  vpc_security_group_ids = [aws_security_group.k8s_sec_gr.id]
  key_name               = "event"
  subnet_id              = "subnet-042907c137a98e049" # Replace with your subnet ID
  availability_zone      = "us-east-1a"
  tags = {
    Name        = "kube-master"
    Project     = "tera-kube-ans"
    Role        = "master"
    Id          = "1"
    environment = "dev"
  }
}

# Worker 1 Node
resource "aws_instance" "worker_1" {
  ami                    = "ami-005fc0f236362e99f"
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.k8s_sec_gr.id]
  key_name               = "event"
  subnet_id              = "subnet-042907c137a98e049" # Replace with your subnet ID
  availability_zone      = "us-east-1a"
  tags = {
    Name        = "worker-1"
    Project     = "tera-kube-ans"
    Role        = "worker"
    Id          = "1"
    environment = "dev"
  }
}

# Worker 2 Node
resource "aws_instance" "worker_2" {
  ami                    = "ami-005fc0f236362e99f"
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.k8s_sec_gr.id]
  key_name               = "event"
  subnet_id              = "subnet-042907c137a98e049" # Replace with your subnet ID
  availability_zone      = "us-east-1a"
  tags = {
    Name        = "worker-2"
    Project     = "tera-kube-ans"
    Role        = "worker"
    Id          = "2"
    environment = "dev"
  }
}

# Outputs
output "kube_master_ip" {
  value       = aws_instance.kube_master.public_ip
  sensitive   = false
  description = "Public IP of the kube-master"
}

output "worker_1_ip" {
  value       = aws_instance.worker_1.public_ip
  sensitive   = false
  description = "Public IP of worker-1"
}

output "worker_2_ip" {
  value       = aws_instance.worker_2.public_ip
  sensitive   = false
  description = "Public IP of worker-2"
}
