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

## Initialize and Validate Terraform

Run these commands from the root directory:

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```


**Terraform init and validation**

<img width="655" height="283" alt="image" src="https://github.com/user-attachments/assets/d6e32296-5869-4192-9c1d-6edf34c9e4f0" />

<img width="598" height="94" alt="image" src="https://github.com/user-attachments/assets/0cbc0b5b-eb81-4037-b08b-9003c722aa98" />

**Terraform plan**

<img width="1026" height="606" alt="image" src="https://github.com/user-attachments/assets/9d2c2287-65c9-4c42-9aa0-ee886b4e6a56" />

---

##  Deploy and Verify Infrastructure

Apply the planned configuration:

```bash
terraform apply
```

**Terraform apply completed**

<img width="1022" height="556" alt="image" src="https://github.com/user-attachments/assets/9e500821-5ebb-42c6-beee-a8de532b2046" />

<img width="831" height="291" alt="image" src="https://github.com/user-attachments/assets/a903f8ad-f070-4f2a-aba6-42addcdd144e" />

**Terraform output**

<img width="593" height="298" alt="image" src="https://github.com/user-attachments/assets/0ee8f98b-8da7-4b73-9e3c-cbd7f89e3897" />

**AWS resources created**

<img width="1210" height="573" alt="image" src="https://github.com/user-attachments/assets/5377f964-7217-4ba3-97bf-a9c00e58c75f" />


**State object in S3**
<img width="1184" height="370" alt="image" src="https://github.com/user-attachments/assets/3c14195d-97a2-4c66-902f-6bd7341c6894" />

---

## 8. State Locking Verification

<img width="923" height="180" alt="image" src="https://github.com/user-attachments/assets/6d5f1982-6519-4e88-81b6-ea8f73e8e01e" />

<img width="703" height="404" alt="image" src="https://github.com/user-attachments/assets/d62b3a6a-1d8d-4a07-8e50-7714360f7313" />



---


## Conclusion

Reusable Terraform modules were organized for the key AWS infrastructure components. The root configuration composes these modules, while the S3 backend stores Terraform state remotely and DynamoDB provides state locking. This structure improves maintainability, reuse, and safer collaboration.
