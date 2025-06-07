# Automate Cloud Resource Provisioning with Terraform

This project demonstrates how to provision cloud resources using Infrastructure as Code (IaC) with Terraform on AWS. It automates the creation of a VPC, an EC2 instance, and an S3 bucket.

## 🚀 Project Goals

- Learn how to write Terraform configuration files.
- Use modules and variables to structure infrastructure.
- Automate creation and destruction of cloud resources.

---

## 📁 Project Structure

```bash
terraform-iac-project/
│
├── main.tf         # Core resources: EC2, VPC, S3
├── variables.tf    # Variables for customization
├── outputs.tf      # Outputs like EC2 IP, VPC ID
├── provider.tf     # AWS provider configuration
└── README.md       # This file

🧱 Resources Provisioned
AWS VPC

EC2 Instance (t2.micro)

S3 Bucket (with random suffix)

🔧 Tools & Technologies
Terraform

AWS (EC2, VPC, S3)

Git + GitHub


✅ Steps to Deploy
1. Clone the Repository
git clone https://github.com/your-username/terraform-iac-project.git
cd terraform-iac-project

2. Configure AWS CLI
aws configure (Command Prompt)

3. Initialize Terraform
terraform init

4. Review Plan
terraform plan

5. Apply Changes
terraform apply

6. Destroy Resources (when done)
terraform destroy


📦 Version Control
This project uses GitHub for version control. Make sure to exclude .terraform/, *.tfstate, and credentials using .gitignore.
