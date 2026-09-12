# Terraform AWS Infrastructure with GitHub Actions CI/CD

![Terraform](https://img.shields.io/badge/Terraform-1.15.8-7B42BC?logo=terraform\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-ap--south--1-FF9900?logo=amazon-aws\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?logo=github-actions\&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?logo=nginx\&logoColor=white)
![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC)

## 📌 Project Overview

This project demonstrates an end-to-end **Infrastructure as Code (IaC)** implementation on AWS using **Terraform**, combined with an automated **GitHub Actions CI/CD pipeline**.

The infrastructure is provisioned using reusable Terraform modules and managed through a remote Terraform backend. GitHub Actions authenticates securely with AWS using **OpenID Connect (OIDC)** instead of storing long-lived AWS access keys.

A protected GitHub Actions `production` environment provides a manual approval gate before Terraform Apply.

The project also provisions an Ubuntu EC2 instance running Nginx and hosts a custom project landing page.

### Project Objectives

The main objectives of this project are to demonstrate practical DevOps skills in:

* Infrastructure as Code using Terraform
* AWS infrastructure provisioning
* Terraform modules
* AWS networking
* EC2 provisioning
* IAM roles and policies
* S3 storage
* Remote Terraform state
* Terraform state locking
* Git and GitHub
* GitHub Actions CI/CD
* GitHub OIDC authentication
* Secure AWS role assumption
* Terraform Plan and Apply automation
* Terraform Plan artifact management
* Production approval gates
* Infrastructure validation

---

# 🏗️ Architecture

```text
                         ┌──────────────────────────┐
                         │       Developer          │
                         │                          │
                         │ Local Terraform Project  │
                         └────────────┬─────────────┘
                                      │
                                      │ git push
                                      ▼
                         ┌──────────────────────────┐
                         │         GitHub           │
                         │                          │
                         │ aws-terraform-           │
                         │ github-actions           │
                         └────────────┬─────────────┘
                                      │
                                      ▼
                         ┌──────────────────────────┐
                         │     GitHub Actions       │
                         │                          │
                         │ Terraform Format        │
                         │ Terraform Init          │
                         │ Terraform Validate      │
                         │ Terraform Plan           │
                         └────────────┬─────────────┘
                                      │
                                      ▼
                              Terraform Plan
                                Artifact
                                      │
                                      ▼
                         ┌──────────────────────────┐
                         │   Production Environment │
                         │                          │
                         │   Manual Approval Gate   │
                         └────────────┬─────────────┘
                                      │
                                      ▼
                         ┌──────────────────────────┐
                         │     Terraform Apply      │
                         │                          │
                         │   Approved tfplan        │
                         └────────────┬─────────────┘
                                      │
                         GitHub OIDC  │
                                      ▼
                         ┌──────────────────────────┐
                         │        AWS IAM           │
                         │                          │
                         │ terraform-github-        │
                         │ actions-role              │
                         └────────────┬─────────────┘
                                      │
                                      ▼
              ┌─────────────────────────────────────────────┐
              │                    AWS                      │
              │                                             │
              │  ┌───────────────────────────────────────┐  │
              │  │                 VPC                   │  │
              │  │              10.0.0.0/16              │  │
              │  │                                       │  │
              │  │   ┌─────────────┐ ┌─────────────┐     │  │
              │  │   │ Public      │ │ Public      │     │  │
              │  │   │ Subnet A    │ │ Subnet B    │     │  │
              │  │   │ 10.0.1.0/24 │ │ 10.0.2.0/24 │     │  │
              │  │   └──────┬──────┘ └─────────────┘     │  │
              │  │          │                            │  │
              │  │          ▼                            │  │
              │  │   ┌─────────────────────┐             │  │
              │  │   │      EC2 Instance   │             │  │
              │  │   │      Ubuntu         │             │  │
              │  │   │      Nginx          │             │  │
              │  │   └──────────┬──────────┘             │  │
              │  │              │                        │  │
              │  └──────────────┼────────────────────────┘  │
              │                 │                           │
              │                 ▼                           │
              │          Elastic IP                         │
              │                 │                           │
              │                 ▼                           │
              │             Internet                        │
              │                                             │
              │   ┌───────────────────────────────────────┐ │
              │   │ Application S3 Bucket                 │ │
              │   └───────────────────────────────────────┘ │
              └─────────────────────────────────────────────┘

                         Terraform Remote State
                                  │
                                  ▼
                    ┌─────────────────────────┐
                    │      S3 Backend         │
                    │                         │
                    │ terraform.tfstate       │
                    │ State Locking            │
                    └─────────────────────────┘
```

---

# 🛠️ Technology Stack

| Category               | Technology        |
| ---------------------- | ----------------- |
| Infrastructure as Code | Terraform         |
| Cloud Platform         | AWS               |
| Region                 | `ap-south-1`      |
| CI/CD                  | GitHub Actions    |
| Source Control         | Git + GitHub      |
| Authentication         | GitHub OIDC       |
| Compute                | Amazon EC2        |
| Operating System       | Ubuntu            |
| Web Server             | Nginx             |
| Networking             | Amazon VPC        |
| Storage                | Amazon S3         |
| Identity & Access      | AWS IAM           |
| State Management       | S3 Remote Backend |
| State Locking          | Terraform         |
| Terraform Version      | `1.15.8`          |
| AWS Provider           | `6.64.0`          |

---

# ☁️ AWS Infrastructure

Terraform provisions and manages the following AWS resources.

## Networking

* VPC
* Two public subnets
* Internet Gateway
* Public route table
* Route table associations
* Security Group

## Compute

* Ubuntu EC2 instance
* Elastic IP
* IAM instance profile
* Nginx web server

## Storage

* Application S3 bucket
* S3 versioning
* S3 encryption
* S3 public access block

## IAM

* EC2 IAM role
* EC2 instance profile
* S3 read-only access
* GitHub Actions IAM role
* GitHub OIDC trust relationship

## Terraform State

* Dedicated S3 remote backend
* Remote Terraform state
* State locking

---

# 🌐 VPC Architecture

The project creates a VPC in the AWS Mumbai region.

```text
Region:
ap-south-1

VPC:
10.0.0.0/16
```

Two public subnets are provisioned across different Availability Zones.

### Public Subnet A

```text
CIDR:
10.0.1.0/24

Availability Zone:
ap-south-1a
```

### Public Subnet B

```text
CIDR:
10.0.2.0/24

Availability Zone:
ap-south-1b
```

### Network Flow

```text
Internet
   │
   ▼
Internet Gateway
   │
   ▼
Public Route Table
   │
   ├───────────────┐
   ▼               ▼
Public Subnet A   Public Subnet B
   │
   ▼
EC2 Instance
```

---

# 🔐 Security Group

The EC2 Security Group follows a minimal inbound access approach.

| Protocol |     Port | Purpose                        |
| -------- | -------: | ------------------------------ |
| TCP      |       22 | SSH administration             |
| TCP      |       80 | HTTP web traffic               |
| All      | Outbound | Required outbound connectivity |

No unnecessary inbound application ports are exposed.

---

# 🖥️ EC2 Configuration

The compute module provisions an Ubuntu EC2 instance.

Terraform `user_data` performs the initial server configuration.

It:

1. Updates the Ubuntu package repository.
2. Installs Nginx.
3. Enables the Nginx service.
4. Starts Nginx.
5. Creates the initial web page.

The EC2 instance is associated with an Elastic IP.

The current application endpoint is:

```text
http://13.204.130.47
```

---

# 📦 Terraform Project Structure

```text
terraform-aws-project/
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── modules/
│   │
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── output.tf
│
├── backend.tf
├── provider.tf
├── main.tf
├── iam.tf
├── s3.tf
├── variables.tf
├── outputs.tf
├── index.html
├── .gitignore
└── README.md
```

---

# 🧩 Terraform Modules

The project uses reusable modules to separate infrastructure responsibilities.

## Networking Module

Location:

```text
modules/networking/
```

Responsibilities:

* VPC creation
* Public subnet creation
* Internet Gateway
* Route table
* Route table associations
* Networking outputs

The root configuration calls this module rather than defining all networking resources directly.

## Compute Module

Location:

```text
modules/compute/
```

Responsibilities:

* EC2 instance
* Elastic IP
* Elastic IP association
* EC2 IAM instance profile
* Initial Nginx configuration

This separation improves maintainability and makes the Terraform configuration easier to reuse.

---

# 🗄️ Terraform Remote State

Terraform state is stored remotely in Amazon S3.

Remote state bucket:

```text
terraform-aws-project-state-382170164329
```

The backend configuration is defined in:

```text
backend.tf
```

Remote state provides:

* Centralized state management
* Persistent state storage
* Separation from the local workstation
* Better collaboration support
* Protection against losing local state

The Terraform state file is **not stored in the Git repository**.

---

# 🔒 Terraform State Locking

State locking prevents multiple Terraform operations from modifying the same infrastructure state simultaneously.

The project uses remote state locking with the configured Terraform backend.

This helps prevent situations such as:

```text
Developer A
     │
     ▼
Terraform Apply
     │
     ├───────────────┐
                     │
Developer B          │
     │               │
     ▼               │
Terraform Apply      │
                     ▼
              State Conflict
```

State locking provides controlled access to the Terraform state during infrastructure operations.

---

# 🔑 IAM Architecture

The project separates IAM responsibilities between EC2 and GitHub Actions.

## EC2 IAM Role

The EC2 instance uses:

```text
terraform-ec2-role
```

with:

```text
terraform-ec2-instance-profile
```

The role provides the required S3 read-only access.

## GitHub Actions IAM Role

GitHub Actions uses:

```text
terraform-github-actions-role
```

This role is assumed using GitHub OIDC.

The two roles have separate purposes:

```text
EC2
 │
 └── terraform-ec2-role

GitHub Actions
 │
 └── terraform-github-actions-role
```

---

# 🔐 GitHub OIDC Authentication

GitHub Actions connects to AWS using **OpenID Connect (OIDC)**.

No long-lived AWS access key or secret key is required inside the GitHub repository for the workflow.

Authentication flow:

```text
GitHub Actions
      │
      │ OIDC Token
      ▼
AWS IAM OIDC Provider
      │
      │ AssumeRole
      ▼
terraform-github-actions-role
      │
      ▼
AWS Infrastructure
```

The IAM trust relationship restricts access to the intended GitHub repository and deployment context.

This is more secure than storing permanent AWS credentials as GitHub secrets.

---

# 🚀 GitHub Actions CI/CD

Workflow:

```text
.github/workflows/terraform.yml
```

The pipeline performs Terraform validation and deployment.

## CI Flow

```text
Git Push / Pull Request
          │
          ▼
Terraform Format
          │
          ▼
Terraform Init
          │
          ▼
Terraform Validate
          │
          ▼
Terraform Plan
          │
          ▼
     tfplan Artifact
```

## CD Flow

```text
Push to main
      │
      ▼
Terraform Plan
      │
      ▼
tfplan Artifact
      │
      ▼
Production Approval
      │
      ▼
Terraform Apply
      │
      ▼
Terraform Outputs
```

---

# 📋 Terraform Plan Artifact

The CI pipeline generates a Terraform execution plan.

The plan is saved as:

```text
tfplan
```

The plan is uploaded as a GitHub Actions artifact.

The Apply job downloads the generated artifact and applies that approved plan.

This provides a controlled workflow:

```text
Terraform Configuration
          │
          ▼
      Terraform Plan
          │
          ▼
     Reviewable Plan
          │
          ▼
    Manual Approval
          │
          ▼
 Apply the Same Plan
```

This avoids generating an unrelated new plan during the deployment stage.

---

# 👤 Production Approval

The GitHub repository uses a protected:

```text
production
```

environment.

The environment requires manual approval before Terraform Apply.

Deployment flow:

```text
Terraform Plan
      │
      ▼
Approval Required
      │
      ▼
Manual Reviewer Approval
      │
      ▼
Terraform Apply
```

This provides an additional control before production infrastructure changes are applied.

---

# 🔄 CI/CD Workflow

The complete workflow is:

```text
Developer
    │
    │ git push
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ├── Format
    ├── Init
    ├── Validate
    └── Plan
          │
          ▼
      tfplan Artifact
          │
          ▼
   Production Approval
          │
          ▼
        Apply
          │
          ▼
   Terraform Outputs
          │
          ▼
     AWS Resources
```

---

# 🪣 Application S3 Bucket

The application infrastructure includes:

```text
terraform-devops-project-382170164329
```

The bucket is configured with:

* Versioning
* Server-side encryption
* Public access block

The application S3 bucket is separate from the Terraform state bucket.

```text
Terraform State Bucket
        │
        └── terraform-aws-project-state-382170164329

Application Bucket
        │
        └── terraform-devops-project-382170164329
```

This separation keeps infrastructure state storage independent from application storage.

---

# 🌍 Application

The EC2 instance runs Nginx and hosts the project landing page.

### Application URL

```text
http://13.204.130.47
```

Application flow:

```text
Internet
    │
    ▼
Elastic IP
    │
    ▼
EC2
    │
    ▼
Nginx
    │
    ▼
index.html
```

The landing page provides information about the Terraform infrastructure and CI/CD implementation.

---

# 📤 Terraform Outputs

The project exposes useful infrastructure information through Terraform outputs.

Examples include:

```text
vpc_id
public_subnet_ids
security_group_id
ec2_instance_id
ec2_private_ip
ec2_public_ip
application_url
s3_bucket_name
iam_role_name
iam_instance_profile_name
```

These outputs make it easier to identify deployed resources and validate the infrastructure after deployment.

---

# 🧪 Validation

The infrastructure was validated through Terraform and AWS.

Validation areas include:

* Terraform configuration syntax
* Terraform formatting
* Terraform validation
* Terraform plan
* Terraform apply
* Terraform outputs
* EC2 availability
* Elastic IP association
* Nginx availability
* Application accessibility
* S3 configuration
* IAM configuration
* Security Group configuration
* Remote state
* State locking
* GitHub Actions execution
* GitHub OIDC authentication
* Production approval gate

---

# 🛡️ Security Practices

The project implements several DevOps security practices.

## No Hardcoded AWS Credentials

AWS access keys are not stored in Terraform source code.

## GitHub OIDC

GitHub Actions obtains temporary AWS credentials through IAM role assumption.

## IAM Roles

AWS IAM roles are used for EC2 and GitHub Actions rather than embedding credentials into infrastructure code.

## Security Group Restrictions

Only required inbound ports are opened:

```text
22 → SSH
80 → HTTP
```

## Remote State

Terraform state is stored remotely rather than committed to Git.

## S3 Protection

The application S3 bucket uses:

* Encryption
* Versioning
* Public access blocking

## Git Ignore

Terraform-generated state and local files are excluded from Git.

---

# 📄 .gitignore

The repository excludes Terraform-generated files and sensitive local configuration.

Important entries include:

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
```

Terraform state should never be committed to the Git repository.

---

# ⚙️ Local Terraform Commands

Initialize Terraform:

```bash
terraform init
```

Format Terraform files:

```bash
terraform fmt -recursive
```

Validate configuration:

```bash
terraform validate
```

Create an execution plan:

```bash
terraform plan
```

View outputs:

```bash
terraform output
```

Check Terraform state:

```bash
terraform state list
```

---

# 🔀 Git Workflow

Infrastructure changes are managed through Git.

Typical workflow:

```bash
git status
git add .
git commit -m "Update infrastructure"
git push origin main
```

After pushing to GitHub, GitHub Actions automatically executes the configured CI/CD workflow.

---

# 📊 Project Completion

| Project Stage                            | Status      |
| ---------------------------------------- | ----------- |
| AWS Infrastructure Provisioning          | ✅ Completed |
| VPC and Networking                       | ✅ Completed |
| EC2 Provisioning                         | ✅ Completed |
| Elastic IP                               | ✅ Completed |
| S3 Application Storage                   | ✅ Completed |
| IAM Configuration                        | ✅ Completed |
| Terraform Variables                      | ✅ Completed |
| Terraform Outputs                        | ✅ Completed |
| Terraform Modules                        | ✅ Completed |
| S3 Security Configuration                | ✅ Completed |
| Remote Terraform State                   | ✅ Completed |
| Terraform State Locking                  | ✅ Completed |
| GitHub Repository                        | ✅ Completed |
| GitHub Actions CI/CD                     | ✅ Completed |
| GitHub OIDC                              | ✅ Completed |
| Terraform Plan Artifact                  | ✅ Completed |
| Production Approval Gate                 | ✅ Completed |
| Terraform Apply through GitHub Actions   | ✅ Completed |
| Terraform Outputs through GitHub Actions | ✅ Completed |
| Application Deployment                   | ✅ Completed |
| Infrastructure Validation                | ✅ Completed |

---

# 📁 Submission Checklist

The project submission includes:

* [x] GitHub Repository
* [x] Terraform Configuration
* [x] Terraform Modules
* [x] GitHub Actions Workflow YAML
* [x] `.gitignore`
* [x] `README.md`
* [x] Remote State Configuration
* [x] Terraform Plan Artifact
* [x] Application URL

---

# 🔗 Project Links

## GitHub Repository

https://github.com/rokidexter/aws-terraform-github-actions

## Application

http://13.204.130.47

---

# 👨‍💻 Author

## Created by Rokith

This project was developed as a hands-on DevOps and Infrastructure as Code portfolio project.

The implementation focuses on practical AWS infrastructure automation, Terraform modularization, secure CI/CD, GitHub OIDC authentication, remote state management, state locking, deployment approvals, and infrastructure validation.

---

# 🎯 Key DevOps Concepts Demonstrated

```text
Infrastructure as Code
        │
        ▼
     Terraform
        │
        ├── Modules
        ├── Variables
        ├── Outputs
        ├── Remote State
        └── State Locking
        │
        ▼
       AWS
        │
        ├── VPC
        ├── Subnets
        ├── Internet Gateway
        ├── Route Tables
        ├── Security Groups
        ├── EC2
        ├── Elastic IP
        ├── S3
        └── IAM
        │
        ▼
   GitHub Actions
        │
        ├── CI
        ├── Terraform Plan
        ├── Plan Artifact
        ├── OIDC
        ├── Production Approval
        └── Terraform Apply
```

---

# 🏁 Final Result

This project demonstrates an end-to-end DevOps workflow in which infrastructure is defined as code, stored in Git, automatically validated and planned through GitHub Actions, reviewed through a protected production approval gate, and deployed to AWS using Terraform.

The deployed AWS infrastructure includes a VPC, public networking, EC2, Elastic IP, IAM, S3, security controls, and an Nginx web server.

The project demonstrates how Terraform and GitHub Actions can be combined to create a repeatable, controlled, and secure infrastructure deployment workflow.

**Terraform + AWS + GitHub Actions + OIDC + CI/CD + Infrastructure as Code**
