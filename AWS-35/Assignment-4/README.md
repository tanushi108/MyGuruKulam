# Assignment 4 — AWS Infrastructure with Terraform

## Overview

This project provisions AWS infrastructure using **Terraform**.

The infrastructure is designed to run an **Amazon EKS cluster** across two Availability Zones with public and private subnets, an Internet Gateway, a single NAT Gateway, security groups, and an EKS Managed Node Group.

Terraform is used to create and manage the infrastructure as code.

---


### Architecture Components

* AWS VPC
* Two Availability Zones
* Two public subnets
* Two private subnets
* Internet Gateway
* One NAT Gateway
* One Elastic IP
* Public Route Table
* Private Route Table
* EKS Cluster
* EKS Managed Node Group
* EKS Cluster Security Group
* EKS Node Security Group

---

##  AWS Region

```text
Region: ap-south-1
```

Availability Zones:

```text
ap-south-1a
ap-south-1b
```


---

## Network Configuration

### VPC

```text
CIDR: 10.0.0.0/16
```

### Public Subnets

| Availability Zone | CIDR        |
| ----------------- | ----------- |
| ap-south-1a       | 10.0.1.0/24 |
| ap-south-1b       | 10.0.3.0/24 |

Public subnets have routes to the Internet Gateway.

### Private Subnets

| Availability Zone | CIDR        |
| ----------------- | ----------- |
| ap-south-1a       | 10.0.2.0/24 |
| ap-south-1b       | 10.0.4.0/24 |

Private subnets use the NAT Gateway for outbound internet connectivity.

<img width="1152" height="330" alt="image" src="https://github.com/user-attachments/assets/ce96bc76-6a3a-4465-ae4a-8bfbedb53b7b" />

---

## NAT Gateway

The architecture uses **one NAT Gateway** to reduce infrastructure cost.

```text
Private Subnet
      |
Private Route Table
      |
NAT Gateway
      |
Internet Gateway
      |
Internet
```

The NAT Gateway is deployed in the public subnet of:

```text
ap-south-1a
```

<img width="1167" height="224" alt="image" src="https://github.com/user-attachments/assets/e7d16d29-4e51-49a8-bc75-cea6628ba5bf" />

---

## Amazon EKS

The project creates an Amazon EKS cluster.

```text
Cluster Name:
assignment4-eks-cluster
```

Kubernetes version:

```text
1.35
```

The EKS cluster uses private subnets from both Availability Zones:

```text
10.0.2.0/24
10.0.4.0/24
```

Using two Availability Zones satisfies the EKS networking requirement for the cluster.

<img width="1193" height="270" alt="image" src="https://github.com/user-attachments/assets/32aede2f-5ae7-4945-8598-fc43da5f1fa3" />

<img width="1146" height="530" alt="image" src="https://github.com/user-attachments/assets/8fbe85f2-0785-46b7-a091-2b160e4ee74d" />


<img width="1164" height="417" alt="image" src="https://github.com/user-attachments/assets/c7f1efef-bbd9-498a-ab40-e94e3bf6e203" />

---

## Terraform Project Structure

```text
terraform/
│
├── backend.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── cluster.tf
└── outputs.tf
```


## Deployment

### 1. Clone the Repository

```bash
git clone https://github.com/tanushi108/Assignment-4-Tool-Infra-Terraform
cd Assignment-4-Tool-Infra-Terraform
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Format Terraform Files

```bash
terraform fmt
```
<img width="736" height="93" alt="image" src="https://github.com/user-attachments/assets/fb52ebc7-e090-4c2c-ba8d-73fe52c0c636" />

### 4. Validate Configuration

```bash
terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

### 5. Review the Execution Plan

```bash
terraform plan
```

Review the resources before applying.

<img width="1111" height="480" alt="image" src="https://github.com/user-attachments/assets/2a9506ec-3510-438f-8c1b-1e59e80696eb" />


### 6. Create Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

when Terraform asks for confirmation.

<img width="793" height="487" alt="image" src="https://github.com/user-attachments/assets/8364e143-cd62-4384-8abd-6fa3f2abf105" />


---

## View Outputs

After deployment:

```bash
terraform output
```

<img width="733" height="284" alt="image" src="https://github.com/user-attachments/assets/3b175079-124d-419a-bba2-1b33b7042fdf" />

---

## Connect to EKS

After the EKS cluster is created, configure `kubectl`:

```bash
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name assignment4-eks-cluster
```

Verify the cluster:

```bash
kubectl get nodes
```

Verify cluster information:

```bash
kubectl cluster-info
```

<img width="1024" height="286" alt="image" src="https://github.com/user-attachments/assets/90614ec3-569f-4ef7-bb8c-322008790c65" />

