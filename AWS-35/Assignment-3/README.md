# Assignment 3 — AWS Nginx High Availability, Auto Scaling, S3, IAM & CDN

## Project Overview

This assignment demonstrates how to design and implement a highly available and scalable **Nginx reverse-proxy and web-hosting infrastructure on AWS**.

The infrastructure is implemented progressively from **Day 1 to Day 6**, starting with manual configuration and gradually introducing:

* Nginx
* AMI-based versioning
* Application Load Balancer
* Auto Scaling Group
* Scaling policies
* Load testing
* Rolling deployment
* Version upgrade and rollback
* S3 static image storage
* IAM Roles
* AWS CLI without access keys
* Bastion Host
* Private EC2 instances
* ALB path-based routing
* S3 bucket policies
* CloudFront/CDN
* IAM trust relationships
* Least-privilege IAM access

---

#  Day 1 — Nginx, AMI Versioning, ASG and High Availability

## Objective

Set up Nginx on EC2, create multiple AMI versions, launch instances from those AMIs and finally build a highly available infrastructure using:

* AMI
* Launch Template
* Auto Scaling Group
* Application Load Balancer
* Scaling Policies
* Load Testing

---

## 1. Create EC2 Instance

Create an EC2 instance with:

* Ubuntu/Amazon Linux
* Required VPC/subnet
* Security Group
* IAM Role
* Required storage

Connect to the instance and install Nginx.

Example:

```bash
sudo apt update
sudo apt install nginx -y
```

Verify:

```bash
sudo systemctl status nginx
```

Test:

```bash
curl http://localhost
```

<img width="1365" height="266" alt="image" src="https://github.com/user-attachments/assets/110986c7-7d88-4c5a-bfd2-874c298136e4" />

---

# 2. Create AMI-1

After installing and configuring Nginx:

```text
EC2
 |
 +-- Nginx Installed
 |
 +-- Initial Configuration
 |
 +-- Create AMI-1
```

AMI-1 represents the initial version of the Nginx server.

Example naming:

```text
assignment-3-day1-nginx-v1
```

<img width="1203" height="289" alt="image" src="https://github.com/user-attachments/assets/f8c56bf3-c41b-4af1-b66f-6df3a9648760" />

---

# 3. Create V1 Instance

Launch a new EC2 instance using:

```text
AMI-1
```

This instance represents:

```text
V1
```

Validate that Nginx is working.

<img width="804" height="347" alt="image" src="https://github.com/user-attachments/assets/54dda02d-1d87-4d26-8739-4522f3034ced" />

---

# 4. Make Changes and Create AMI-2

Make configuration/content changes on V1.

For example:

```bash
sudo nano /var/www/html/index.html
```

Change the webpage from:

```text
Nginx Version 1
```

to:

```text
Nginx Version 2
```

Create another AMI:

```text
nginx-version-2
```

This becomes:

```text
assignment-3-day1-nginx-v2

```
<img width="1237" height="302" alt="image" src="https://github.com/user-attachments/assets/5fde7b95-b994-4081-b725-cace36c2d4e1" />

---

# 5. Create V2 Instance

Launch another EC2 instance from:

```text
assignment-3-day1-nginx-v2
```

This instance represents:

```text
V2
```

Now the infrastructure contains:

```text
AMI-1 → V1
AMI-2 → V2
```

---
## version chain
```
Original EC2
     |
     └── AMI-1
          |
          └── V1
               |
               └── Changes
                    |
                    └── AMI-2
                         |
                         └── V2
```
<img width="1365" height="590" alt="image" src="https://github.com/user-attachments/assets/16f66c23-3efc-4f07-86c6-8b37bac213fb" />

<img width="824" height="266" alt="image" src="https://github.com/user-attachments/assets/44075cee-1ef9-40ee-a73a-d3b264cd0135" />

# 6. Launch Template

Create a Launch Template using the required AMI.

The Launch Template should define:

* AMI
* Instance type
* IAM role
* Security group
* Storage
* User data if required

Example:

```text
Launch Template
       |
       v
     AMI-1
       |
       v
     Nginx
```

---

# 7. Create Target Group

Create an ALB Target Group.

Example:

```text
Target Group
Protocol: HTTP
Port: 80
Health Check: /
```

Register the required Nginx instances.

Verify:

```text
Target Health = Healthy
```
<img width="1227" height="622" alt="image" src="https://github.com/user-attachments/assets/7708bd33-54c6-432e-a0dc-2cd45c1a532a" />

---

# 8. Create Application Load Balancer

Create an internet-facing Application Load Balancer.

Configuration:

```text
Listener:
HTTP : 80

Target:
Nginx Target Group
```

Traffic flow:

```text
Client
  |
  v
ALB
  |
  v
Nginx
```

<img width="1221" height="609" alt="image" src="https://github.com/user-attachments/assets/c2692a1f-93d9-4642-a9dc-cc4b4fe45e4f" />

---

# 9. Create Auto Scaling Group

Create an Auto Scaling Group using the Launch Template.

Example:

```text
Minimum Capacity = 2
Desired Capacity = 2
Maximum Capacity = 4
```

Attach the Target Group to the ASG.

Architecture:

```text
                 ALB
                  |
          +-------+-------+
          |               |
       Nginx-1         Nginx-2
          \               /
           \             /
              ASG
```

<img width="1172" height="261" alt="image" src="https://github.com/user-attachments/assets/55b4e650-fa61-4a6a-8e58-cb5100ccee3f" />

---
## verify verion from alb

<img width="1365" height="235" alt="image" src="https://github.com/user-attachments/assets/c0bfa70b-f1e0-4a7a-9fc0-ede872bbf2a7" />


#  Launch Template Version 2
A new version of the existing Launch Template was created using the Nginx Version 2 AMI.

Launch Template: a3-nginx-v1-lt

Version: 2

AMI: a3-nginx-v2-ami

The remaining launch configuration was kept consistent with Version 1.

<img width="1229" height="503" alt="image" src="https://github.com/user-attachments/assets/0aa5312a-4cf1-4361-85fa-b583805234fd" />

---

# Rollback to version 1

To verify the rollback mechanism, the Auto Scaling Group was reverted to Launch Template Version 1.

Launch Template: a3-nginx-v1-lt

Version: 1

Another Instance Refresh was started to replace the Version 2 instances with Version 1 instances.

<img width="1322" height="557" alt="image" src="https://github.com/user-attachments/assets/d6b55854-d4c7-4927-aa55-13f6e5732681" />

# Verify Rollback Through ALB
After the rollback Instance Refresh completed, the ALB DNS name was accessed again.

The Nginx Version 1 webpage was successfully displayed.

This confirmed that the infrastructure could be rolled back from Version 2 to Version 1 using the previous Launch Template version.

<img width="1365" height="256" alt="image" src="https://github.com/user-attachments/assets/d66e1e7d-07a4-4e89-8657-ba32d0553e72" />

---

#  Day 2 — Nginx Web Hosting + S3

## Objective

Modify Nginx so that it can host a webpage and retrieve images from S3.

All operations must be performed from the AWS environment/EC2.

---

# 1. Source Code from Git

Clone the webpage repository from the VCS repository.

Example:

```bash
git clone [<repository-url>](https://github.com/tanushi108/assignment-3-AWS-day2)
```


---
# 2 Install AWS CLI, Nginx and Git
Installed AWS CLI:

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip -y

unzip awscliv2.zip

sudo ./aws/install

** Installed Nginx and Git: **

sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

sudo apt update

sudo apt install nginx git -y

<img width="886" height="306" alt="image" src="https://github.com/user-attachments/assets/fe45bc63-3766-453e-8173-cd22390d96ac" />


---


# 3. Upload Images to S3 Using AWS CLI

The client specifically does not want hard-coded AWS access keys.

Therefore, attach an IAM Role to the EC2 instance.

Example IAM permissions:

```text
s3:PutObject
s3:GetObject
s3:ListBucket
```

Then verify:

```bash
aws sts get-caller-identity
```

git clone and Upload images:

```bash
git clone https://github.com/tanushi108/assignment-3-AWS-day2.git
aws s3 cp aws (2).jpg s3://assignment-3-nginx-assets-2026 /images/
```

<img width="462" height="225" alt="image" src="https://github.com/user-attachments/assets/b462fbdb-b72b-4009-b398-ac01ef0ab180" />



<img width="1176" height="587" alt="image" src="https://github.com/user-attachments/assets/4b45cc15-eea5-4616-ae87-4444b2f0a918" />

<img width="605" height="110" alt="image" src="https://github.com/user-attachments/assets/c5cd5121-81f4-40ed-981d-a87c5a419128" />


---

# 4. Nginx Frontend

Create the webpage inside:

```text
/var/www/html/
```


<img width="487" height="276" alt="image" src="https://github.com/user-attachments/assets/d0c7e659-0393-4e3c-aa93-eb7cadd1aaa2" />

<img width="1365" height="411" alt="image" src="https://github.com/user-attachments/assets/58f8321b-e932-4961-88e7-9d5b684f9c26" />

<img width="1257" height="683" alt="image" src="https://github.com/user-attachments/assets/42ff8b64-3828-4e47-81e1-4642ec9efee0" />

---

# Day 3 — Auto Scaling Health Check and Recovery

## Objective

Test whether ASG can maintain the desired number of healthy instances when an instance becomes unhealthy.

---

# 1. Enter Nginx Instance

Connect to the private server through the approved access mechanism.

---

# 2. Make Instance Unhealthy

For testing, intentionally stop Nginx:

```bash
sudo systemctl stop nginx
```

Now verify:

```bash
sudo systemctl status nginx
```

The instance should fail the application/target health check depending on the configured health-check design.

<img width="923" height="282" alt="image" src="https://github.com/user-attachments/assets/0083d6b6-857c-4beb-b3c3-a64cf09ad5eb" />

---

# 3. Observe ASG

Monitor:

```text
Target Group
      |
      v
Unhealthy Target
      |
      v
ASG
      |
      v
New Instance
      |
      v
Healthy Target
```

Check:

```text
Desired Capacity
Current Capacity
InService Instances
Unhealthy Instances
```

<img width="1203" height="560" alt="image" src="https://github.com/user-attachments/assets/883205ee-9104-4ad6-a254-d6acd99ef142" />


<img width="1173" height="574" alt="image" src="https://github.com/user-attachments/assets/92f2873b-f657-45f9-8925-f99bcf7c1542" />

<img width="1159" height="196" alt="image" src="https://github.com/user-attachments/assets/3de9d488-1602-4d26-a3f3-2394e37b5dec" />

<img width="1216" height="543" alt="image" src="https://github.com/user-attachments/assets/fa66a836-b55b-47a6-aa18-ec24a858a599" />

---

# 4. Desired State

Example:

```text
Desired Capacity = 2
```

If one instance becomes unhealthy and is terminated/replaced according to the configured health checks, ASG should work toward maintaining:

```text
Desired Capacity = 2
```

<img width="1152" height="194" alt="image" src="https://github.com/user-attachments/assets/9bcc46ce-30ab-47d8-86c9-ec298b108e89" />

---

#  Deployment Utility Requirement

The final solution should be designed so that a deployment utility can:

```text
Create AMI
     |
     v
Create/Update Launch Template
     |
     v
Attach Version to ASG
     |
     v
Rolling Deployment
     |
     +------> Rollback
```

The utility should support:

### Version Creation

```text
V1 → AMI-1
V2 → AMI-2
V3 → AMI-3
```

### Deployment

```text
Select Version
      |
      v
Create Launch Template Version
      |
      v
Update ASG
      |
      v
Rolling Replacement
```



---
# Day 4 — Path-Based Routing, Private EC2 & S3 Integration

##  Objective

Implement path-based routing using one Application Load Balancer with two Target Groups and two private Nginx application servers.

```text
/ninja1 → Target Group 1 → Ninja 1
/ninja2 → Target Group 2 → Ninja 2
```

Application images are served from Amazon S3.

---

## 1. Create Second Target Group

Created:

```text
day-4-nginx-tg
```

Configuration:

```text
Target Type: Instance
Protocol: HTTP
Port: 80
VPC: assignment-3-vpc
Health Check Path: /
```

### Screenshot

<img width="1207" height="555" alt="image" src="https://github.com/user-attachments/assets/65db915b-44e6-4a2f-8797-c5e5a11a1cab" />


---

## 2. Launch Ninja 2 Private EC2

Created:

```text
Name: day4-ec2-v2
AMI: assignment3-day1-nginx-v2
Instance Type: t3.micro
VPC: assignment3-vpc
Subnet: assignment3-public
Public IP: Disabled
IAM Role: assignment-3-ec2-role
```

Private IP:

```text
10.0.0.147
```

Availability Zone:

```text
ap-south-1b
```

The instance was accessed through the Bastion Host.

<img width="1185" height="470" alt="image" src="https://github.com/user-attachments/assets/2e13b1cf-2bfa-453b-b9d7-950b739f86a4" />

---

## 3. Configure Security Group

The Ninja 2 instance uses:

```text
assignment-3-day4-sg
```

Expected rules:

```text
SSH 22  → Bastion Security Group
HTTP 80 → ALB Security Group
Outbound → All Traffic
```

The application server has no public IP.

---

## 4. Configure Ninja 2 Nginx Page

Configured a separate Ninja 2 page containing:

```text
AWS Assignment 3
Nginx - Ninja 2
Phase 4 - Path Based Routing
Server: NINJA 2
Private Subnet: 10.0.12.0/24
```

The page also loads an image directly from Amazon S3.

---

## 5. Register Ninja 2 Target

Registered:

```text
day4-ec2-v2
```

with:

```text

day4-v2-nginx-tg
```

Port:

```text
80
```

After attaching the Target Group to the ALB, the target became:

```text
Healthy ✅
```

### Screenshot

<img width="1200" height="536" alt="image" src="https://github.com/user-attachments/assets/06e91110-6ad2-44c6-af71-cb5bcf48b830" />


---

## 6. Configure ALB Path-Based Routing

Existing ALB:

```text
day4-alb
```

HTTP listener:

```text
HTTP :80
```

### Rule 1

```text
Priority: 1
IF Path = /ninja1*
THEN Forward to a3-nginx-tg
```

### Rule 2

```text
Priority: 2
IF Path = /ninja2*
THEN Forward to a3-nginx-ninja2-tg
```


---

## 7. Configure ALB URL Rewrite

Initially, `/ninja1` returned `404 Not Found` because Nginx had `index.html` at `/`.

ALB URL rewrite was therefore configured.

### Ninja 1

```text
Regex:
^/ninja1/?(.*)$

Replacement:
/$1
```

### Ninja 2

```text
Regex:
^/ninja2/?(.*)$

Replacement:
/$1
```

This converts:

```text
/ninja1 → /
/ninja2 → /
```

before forwarding the request to Nginx.

<img width="1181" height="537" alt="image" src="https://github.com/user-attachments/assets/1d2b3a7f-6635-4dde-9173-0a554affc470" />

---

## 8. Verify Ninja 1

URL:

```text
http://day-4-alb-888376673.ap-south-1.elb.amazonaws.com/ninja1
```

Routing:

```text
/ninja1
   ↓
ALB
   ↓
a3-nginx-tg
   ↓
Private Nginx / Ninja 1
```

The Ninja 1 page was successfully displayed.

### Screenshot

<img width="1365" height="642" alt="image" src="https://github.com/user-attachments/assets/deb8eb54-f986-4b97-89c2-2bbfc17adabf" />


---

## 9. Verify Ninja 2

URL:

```text
http://day-4-alb-888376673.ap-south-1.elb.amazonaws.com/ninja2
```

Routing:

```text
/ninja2
   ↓
ALB
   ↓
a3-nginx-ninja2-tg
   ↓
Private Nginx / Ninja 2
```

The Ninja 2 page was successfully displayed.

The S3 image was also successfully loaded.

### Screenshot

<img width="1361" height="683" alt="image" src="https://github.com/user-attachments/assets/42eaa30c-4d5f-423c-a0a7-2556765fddf6" />

---

## 10. S3 Image Integration

The Ninja 2 webpage loads the image directly from Amazon S3.

<img width="1176" height="432" alt="image" src="https://github.com/user-attachments/assets/dd2ed25c-0951-466a-9a75-193f90bb2cc6" />


---

#  Day 5 — S3, IAM and Environment Separation

## Objective

Create a secure S3 environment with separate:

```text
prod
nonprod
```

folders.


---

# 1. Create S3 Bucket

Example:

```text
assignment-3-day-5-tanushi-2026
```
in `us-east-1`region 

Inside the bucket:

```text
bucket/
├── prod/
└── nonprod/
```
<img width="911" height="467" alt="image" src="https://github.com/user-attachments/assets/94404cae-61c4-4b6c-80a9-ca7d76cb1169" />

<img width="1362" height="402" alt="image" src="https://github.com/user-attachments/assets/f597c1ea-7cbb-4cf5-9b2e-915fc001469c" />

---

# 2. Upload Images

Example:

```text
prod/
   ├── prod-image1.jpg
   └── prod-image2.jpg

nonprod/
   ├── nonprod-image1.jpg
   └── nonprd-image2.jpg
```

<img width="1363" height="365" alt="image" src="https://github.com/user-attachments/assets/1aaf56dd-82ad-4b04-93b2-f18d79ce662c" />


<img width="1365" height="330" alt="image" src="https://github.com/user-attachments/assets/df45f624-92c6-4e5e-9fa0-108942be57e6" />

---

# 3. Create IAM User

Create an IAM user for the required S3 access.

The user should not automatically receive unrestricted access to the entire bucket.

The requirement is:

```text
IAM User
   |
   +-- nonprod = Allowed
   |
   +-- prod = Denied
```

---

# 4. IAM Role

Create an IAM Role for the application/EC2 task.

The role should provide only the permissions required for the S3 operation.

Example permissions may include:

```text
s3:ListBucket
s3:GetObject
s3:PutObject
```

depending on the exact task.

Attach the role to the EC2 instance instead of storing access keys.


<img width="1151" height="266" alt="image" src="https://github.com/user-attachments/assets/e9aff515-195b-4769-b9e3-c1c8e98dee81" />

---

# 5. IAM User Restriction

The IAM user should be able to access:

```text
s3://bucket/nonprod/*
```

but should not be able to access:

```text
s3://bucket/prod/*
```

Example policy concept:

```text
Allow:
arn:aws:s3:::BUCKET/nonprod/*

Deny:
arn:aws:s3:::BUCKET/prod/*
```

The final policy should be tested using the IAM Policy Simulator and actual CLI/API calls.

<img width="1256" height="519" alt="image" src="https://github.com/user-attachments/assets/c481a75f-e938-4da4-bf15-ec14b1e7df35" />

---

# 6. Bucket Access

The bucket policy must be designed carefully so that access is limited to the required principals.

Required principals may include:

```text
Root
IAM User
EC2 IAM Role
CloudFront/CDN service
```

Do not make the entire bucket public unless explicitly required.


<img width="1365" height="310" alt="image" src="https://github.com/user-attachments/assets/d55198d0-3547-4d16-b95b-68a448d9d57d" />

<img width="394" height="72" alt="image" src="https://github.com/user-attachments/assets/233bc8cb-57bf-4e72-ae65-da6fecbab2a5" />

---

#  Day 6 — CloudFront, IAM Trust Relationship and Least Privilege

## Objective

Introduce CloudFront so that clients retrieve images through CDN instead of directly from S3.

Architecture:

```text
Client
   |
   v
CloudFront
   |
   v
S3
   |
   v
Images
```

---

# 1. CloudFront Distribution

Create a CloudFront distribution with S3 as the origin.

```text
CloudFront
     |
     v
S3 Bucket
```

The client accesses:

```text
CloudFront URL
```

instead of directly accessing S3 objects.

---

# 2. S3 Origin Security

Configure the S3 bucket so that CloudFront can retrieve the required objects while direct public access remains restricted.

Use the appropriate CloudFront-to-S3 origin access mechanism.

---

# 3. IAM Trust Relationship

An IAM policy controls:

```text
What the principal can do
```

while a trust policy controls:

```text
Who can assume/use the role
```

Conceptually:

```text
IAM Role
   |
   +-- Permissions Policy
   |
   +-- Trust Policy
```

The trust relationship must identify the appropriate trusted principal/service.

---

# 4. Important IAM Concept

There are two different concepts:

### Permissions Policy

Defines:

```text
What can I access?
```

Example:

```text
s3:GetObject
s3:PutObject
```

### Trust Policy

Defines:

```text
Who can assume this role?
```

Example:

```text
EC2
CloudFront/service principal
```

These policies serve different purposes and cannot simply be interchanged.

---

# 5. Reuse of IAM Role

The assignment asks to use the same role for CDN and EC2 without modifying the existing permissions policy.

Before doing this, verify that the role's trust relationship permits the required principal.

The trust relationship should be configured only for legitimate principals and should follow least privilege.

---

# 6. IAM User for DevOps Task

Create a separate IAM user for performing the required task.

Grant only the permissions required for:

```text
S3
CloudFront
IAM
```

Do not attach unnecessary administrator permissions.

Follow:

```text
Least Privilege
```

