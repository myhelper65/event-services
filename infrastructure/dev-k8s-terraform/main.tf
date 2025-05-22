provider "aws" {
  region = "us-east-1"
}

variable "sec_gr_k8s" {
  default = "eventserver-ansible-test-dev.keyserver-k8s-sec-group"
}

data "aws_vpc" "name" {
  default = true
}

resource "aws_security_group" "k8s_sec_gr" {
  name   = var.sec_gr_k8s
  vpc_id = data.aws_vpc.name.id
  tags = {
    Name = var.sec_gr_k8s
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self      = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 6443
    to_port     = 6443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "eventserver_ansible_test_dev_keyserver_master_server_s3_role" {
  name               = "eventserver-ansible-test-dev.keyserver-master-server-role"
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

resource "aws_iam_role_policy_attachment" "eventserver_ansible_test_dev_keyserver_s3_policy" {
  role       = aws_iam_role.eventserver_ansible_test_dev_keyserver_master_server_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "eventserver_ansible_test_dev_keyserver_master_server_profile" {
  name = "eventserver-ansible-test-dev.keyserver-master-server-profile"
  role = aws_iam_role.eventserver_ansible_test_dev_keyserver_master_server_s3_role.name
}

resource "aws_instance" "kube_master" {
  ami                    = "ami-005fc0f236362e99f"
  instance_type          = "t3a.medium"
  iam_instance_profile   = aws_iam_instance_profile.eventserver_ansible_test_dev_keyserver_master_server_profile.name
  vpc_security_group_ids = [aws_security_group.k8s_sec_gr.id]
  key_name               = "eventserver-ansible-test-dev.key"
  subnet_id              = "subnet-042907c137a98e049"
  availability_zone      = "us-east-1a"
  tags = {
    Name        = "kube-master"
    Project     = "tera-kube-ans"
    Role        = "master"
    Id          = "1"
    environment = "dev"
  }
}

resource "aws_instance" "worker_1" {
  ami                    = "ami-005fc0f236362e99f"
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.k8s_sec_gr.id]
  key_name               = "eventserver-ansible-test-dev.key"
  subnet_id              = "subnet-042907c137a98e049"
  availability_zone      = "us-east-1a"
  tags = {
    Name        = "worker-1"
    Project     = "tera-kube-ans"
    Role        = "worker"
    Id          = "1"
    environment = "dev"
  }
}

resource "aws_instance" "worker_2" {
  ami                    = "ami-005fc0f236362e99f"
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.k8s_sec_gr.id]
  key_name               = "eventserver-ansible-test-dev.key"
  subnet_id              = "subnet-042907c137a98e049"
  availability_zone      = "us-east-1a"
  tags = {
    Name        = "worker-2"
    Project     = "tera-kube-ans"
    Role        = "worker"
    Id          = "2"
    environment = "dev"
  }
}

output "kube_master_ip" {
  value       = aws_instance.kube_master.public_ip
  sensitive   = false
  description = "public ip of the kube-master"
}

output "worker_1_ip" {
  value       = aws_instance.worker_1.public_ip
  sensitive   = false
  description = "public ip of the worker-1"
}

output "worker_2_ip" {
  value       = aws_instance.worker_2.public_ip
  sensitive   = false
  description = "public ip of the worker-2"
}
