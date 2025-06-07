# main.tf
# main.tf - VPC Definition
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MainVPC"
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2" {
  # IMPORTANT: Find an AMI ID specific to your chosen region (e.g., us-east-1, ca-central-1)
  # Example for Amazon Linux 2 in us-east-1: ami-053b0d53c279acc90
  # You can search for "Amazon Linux 2 AMI" in the EC2 console under Launch Instance
  ami           = "ami-053b0d53c279acc90" # <--- **CHANGE THIS TO A VALID AMI FOR YOUR REGION**
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id] # Add this, we'll define it below
  subnet_id     = aws_subnet.main_subnet.id # Add this, we'll define it below
  associate_public_ip_address = true # Ensure it gets a public IP for the output

  tags = {
    Name = "MyTerraformEC2"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  # IMPORTANT: S3 bucket names must be GLOBALLY UNIQUE.
  # Change this to something very unique, e.g., "my-unique-terraform-bucket-sherv-20250607"
  bucket = "my-unique-terraform-bucket-sherv-123456789" # <--- **CHANGE THIS TO A GLOBALLY UNIQUE NAME**
  tags = {
    Name = "MyTerraformS3Bucket"
  }
}

# Add a public subnet for the EC2 instance
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # <--- Choose an AZ in your region (e.g., ca-central-1a)
  map_public_ip_on_launch = true # Required for public IP

  tags = {
    Name = "MainSubnet"
  }
}

# Add an Internet Gateway to allow external communication for the VPC
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MainIGW"
  }
}

# Add a route table to direct traffic through the Internet Gateway
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = {
    Name = "MainRouteTable"
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "main_rta" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_rt.id
}


# Security Group for EC2 - allows SSH and HTTP
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Be careful with 0.0.0.0/0 for SSH in production
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSHHTTP"
  }
}