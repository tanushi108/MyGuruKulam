# Terraform Infrastructure Using Reusable Modules

## Assignment Overview

This assignment demonstrates how to build reusable Terraform modules for AWS infrastructure and manage Terraform state remotely using Amazon S3 with DynamoDB state locking.

### Objectives
- Organize infrastructure code into reusable Terraform modules.
- Create AWS networking and compute resources using modules.
- Store Terraform state in an Amazon S3 bucket.
- Use a DynamoDB table for state locking to help prevent concurrent state operations.
- Follow Terraform code organization and version-control best practices.

---

## Architecture

The configuration is organized into a root module and child modules:

```text
terraform-modules-assignment/
├── backend/
│   └── backend.tf              # S3 backend configuration
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── subnets/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── instance/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf                     # Calls the modules
├── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars           
└── README.md
```



---

## Prerequisites

- Terraform CLI installed.
- AWS CLI installed and configured.
- AWS account with permissions to create the required resources.
- An AWS region selected for deployment.
- An S3 bucket and DynamoDB table created before configuring the remote backend.

Verify the tools:

```bash
terraform version
aws --version
aws sts get-caller-identity
```

---

## 1. Configure AWS Provider

The root configuration declares the AWS provider and region. Keep provider configuration in the root module and pass provider context to child modules as needed.

Example:

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
```

---

## 2. Create Reusable Terraform Modules

Each module should have a focused responsibility and expose configurable inputs through `variables.tf`. Use `outputs.tf` to return values required by other modules.

### VPC Module
Creates the VPC and exports its ID.

### Subnets Module
Creates public and/or private subnets using the VPC ID and subnet CIDR blocks supplied by the root module.

### Security Group Module
Defines inbound and outbound rules. Restrict inbound access to only the ports and source ranges required for the assignment.

### EC2 Instance Module
Creates an EC2 instance using inputs such as AMI ID, instance type, subnet ID, security group IDs, and tags.

**Screenshot 1 – Terraform modules directory**

![Modules Directory](screenshots/01-modules.png)

---

## 3. Call Modules from the Root Configuration

The root module wires the components together by passing outputs from one module into the inputs of another.


Update module input/output names to match your implementation.

**Screenshot 2 – Root module calling child modules**

![Root Module](screenshots/02-root-module.png)

---

## 4. Configure Remote Terraform State in S3

Terraform state records the resources managed by Terraform. A remote backend stores the state outside the local working directory, allowing authorized team members and automation to use a shared state location.

Before initialization, create the S3 bucket and DynamoDB table. Recommended S3 settings:
- Enable bucket versioning to help recover earlier state versions.
- Block public access.
- Enable server-side encryption.
- Apply least-privilege access to the bucket.
- Use a unique bucket name.

Example backend configuration (place in a Terraform configuration file):


Replace the placeholders with your actual S3 bucket and DynamoDB table names. The region must match the location of the S3 bucket.

---

## 5. Configure DynamoDB State Locking

Create a DynamoDB table for Terraform locking with:
- Partition key: `LockID`
- Key type: `String`
- Billing mode: On-demand is suitable for a small assignment.

Terraform uses the configured table to coordinate state operations and reduce the risk of simultaneous changes to the same state.

> Note: This assignment uses DynamoDB locking as requested. Check the documentation for your installed Terraform version for current backend recommendations; newer Terraform versions also support S3-native lock files.

---

## 6. Initialize and Validate Terraform

Run these commands from the root directory:

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

If Terraform asks whether to copy existing local state to the S3 backend, review the prompt carefully and confirm only when the destination backend is correct.

**Terraform init and validation**

<img width="655" height="283" alt="image" src="https://github.com/user-attachments/assets/d6e32296-5869-4192-9c1d-6edf34c9e4f0" />

<img width="598" height="94" alt="image" src="https://github.com/user-attachments/assets/0cbc0b5b-eb81-4037-b08b-9003c722aa98" />

**Terraform plan**

<img width="1026" height="606" alt="image" src="https://github.com/user-attachments/assets/9d2c2287-65c9-4c42-9aa0-ee886b4e6a56" />

---

## 7. Deploy and Verify Infrastructure

Apply the planned configuration:

```bash
terraform apply
```

Review the proposed changes and type `yes` when ready.

Verify the created AWS resources in the AWS Console or with the AWS CLI. Confirm that the EC2 instance is associated with the expected subnet and security group, and that the VPC/subnets match the intended design.

**Terraform apply completed**

<img width="1022" height="556" alt="image" src="https://github.com/user-attachments/assets/9e500821-5ebb-42c6-beee-a8de532b2046" />

<img width="831" height="291" alt="image" src="https://github.com/user-attachments/assets/a903f8ad-f070-4f2a-aba6-42addcdd144e" />

**Terraform output**

<img width="593" height="298" alt="image" src="https://github.com/user-attachments/assets/0ee8f98b-8da7-4b73-9e3c-cbd7f89e3897" />

**Screenshot 6 – AWS resources created**

![AWS Resources](screenshots/06-aws-resources.png)

**Screenshot 7 – State object in S3**

![S3 Terraform State](screenshots/07-s3-state.png)

---

## 8. State Locking Verification 


---


## Conclusion

Reusable Terraform modules were organized for the key AWS infrastructure components. The root configuration composes these modules, while the S3 backend stores Terraform state remotely and DynamoDB provides state locking. This structure improves maintainability, reuse, and safer collaboration.



















<img width="685" height="352" alt="image" src="https://github.com/user-attachments/assets/40aa9e7b-b616-4e82-8708-c54d443194c5" />

<img width="983" height="329" alt="image" src="https://github.com/user-attachments/assets/6deb9c06-cdd0-4d4c-8864-c48f64666b7e" />


<img width="954" height="323" alt="image" src="https://github.com/user-attachments/assets/79690ea9-cbc3-446b-97b8-fc691b14b3eb" />


<img width="923" height="180" alt="image" src="https://github.com/user-attachments/assets/6d5f1982-6519-4e88-81b6-ea8f73e8e01e" />
