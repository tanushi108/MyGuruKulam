# Assignment 3 — AWS Nginx High Availability, Auto Scaling, S3, IAM & CDN

## 📌 Project Overview

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

> **Important:** All tasks are first performed manually through the AWS Console/EC2 environment as required by the client. Automation is considered only after the manual implementation is successfully validated.

---

# 🏗️ Overall Architecture

```text
                         Internet
                            |
                            |
                     Public IP Only
                            |
                            v
                    +----------------+
                    |      ALB       |
                    | Port 80        |
                    | Path Routing   |
                    +-------+--------+
                            |
             +--------------+--------------+
             |                             |
        /ninja1                        /ninja2
             |                             |
             v                             v
     +---------------+             +---------------+
     | Private EC2-1 |             | Private EC2-2 |
     | Nginx         |             | Nginx         |
     | Image-1       |             | Image-2       |
     +---------------+             +---------------+
             |                             |
             +-------------+---------------+
                           |
                           v
                       S3 Bucket
                    +-------------+
                    | prod/       |
                    | nonprod/     |
                    +-------------+
                           |
                           v
                       CloudFront
                           |
                           v
                        Clients
```

---

# 📅 Day 1 — Nginx, AMI Versioning, ASG and High Availability

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
nginx-version-1
```

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
AMI-2
```

---

# 5. Create V2 Instance

Launch another EC2 instance from:

```text
AMI-2
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

---

# 9. Create Auto Scaling Group

Create an Auto Scaling Group using the Launch Template.

Example:

```text
Minimum Capacity = 1
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

---

# 10. Scaling Policies

Test different Auto Scaling policies.

The assignment requires testing:

* Average CPU Utilization
* Network Bytes In
* Network Bytes Out
* ALB Request Count Per Target

---

## Policy 1 — Average CPU Utilization

Configure Target Tracking Scaling based on:

```text
Average CPU Utilization
```

Example:

```text
Target = 50%
```

When CPU increases beyond the target, ASG launches additional instances.

---

## Policy 2 — Network Bytes In

Use:

```text
NetworkIn
```

as the scaling metric.

Generate network traffic and observe ASG behavior.

---

## Policy 3 — Network Bytes Out

Use:

```text
NetworkOut
```

as the scaling metric.

Generate outbound traffic and monitor:

```text
NetworkOut
Desired Capacity
InService Instances
```

---

## Policy 4 — ALB Request Count Per Target

Use:

```text
ALB Request Count Per Target
```

as the scaling metric.

Traffic flow:

```text
Client
   |
   v
 ALB
   |
   v
Target Group
   |
   v
Nginx
```

When requests increase, ASG can add instances according to the configured policy.

---

# 11. Load Testing

Generate load against the Nginx server/ALB.

Example:

```bash
stress --cpu 2 --timeout 300
```

or use an appropriate HTTP load-testing tool against the ALB.

Monitor:

```text
EC2 → CPUUtilization
EC2 → NetworkIn
EC2 → NetworkOut
ALB → RequestCount
ASG → DesiredCapacity
ASG → InServiceInstances
```

---

# 📊 Analysis

During testing record:

| Metric                  | Observation  |
| ----------------------- | ------------ |
| Average CPU Utilization | Record value |
| Network Bytes In        | Record value |
| Network Bytes Out       | Record value |
| ALB Request Count       | Record value |
| Desired Capacity        | Record value |
| Running Instances       | Record value |
| Scaling Time            | Record value |

---

# 🔄 Version Upgrade

Suppose the application currently uses:

```text
V1
```

and the client requests:

```text
V2
```

The deployment strategy should use:

```text
V1 AMI
   |
   v
V2 AMI
   |
   v
New Launch Template Version
   |
   v
ASG
```

The old version should remain available for rollback.

---

# 🔙 Rollback

If V2 is incompatible with the application:

```text
V2
 |
 X
 |
 v
Rollback
 |
 v
V1
```

Rollback procedure:

1. Keep AMI-1 available.
2. Change Launch Template to the V1 AMI/version.
3. Update the ASG.
4. Replace V2 instances gradually.
5. Verify Target Group health.
6. Verify application functionality.
7. Confirm that traffic is served by V1.

---

# 📅 Day 2 — Nginx Web Hosting + S3

## Objective

Modify Nginx so that it can host a webpage and retrieve images from S3.

All operations must be performed from the AWS environment/EC2.

---

# 1. Source Code from Git

Clone the webpage repository from the VCS repository.

Example:

```bash
git clone <repository-url>
```

Move into the project:

```bash
cd <repository-directory>
```

---

# 2. Upload Images to S3 Using AWS CLI

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

Upload images:

```bash
aws s3 cp image1.jpg s3://<bucket-name>/images/
```

Upload complete directory:

```bash
aws s3 cp ./images s3://<bucket-name>/images/ --recursive
```

No:

```text
AWS Access Key
AWS Secret Access Key
```

is stored on the server.

---

# 3. Nginx Frontend

Create the webpage inside:

```text
/var/www/html/
```

Example structure:

```text
/var/www/html/
├── index.html
├── css/
├── js/
└── images/
```

Images can be referenced from S3:

```html
<img src="https://<bucket-or-cloudfront-url>/images/image1.jpg">
```

---

# 📅 Day 3 — Auto Scaling Health Check and Recovery

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

---

# 🔄 Deployment Utility Requirement

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

### Rollback

```text
Current Version
      |
      v
Previous AMI
      |
      v
Previous Launch Template
      |
      v
ASG
```

---

# 🔵🟢 Optional — Blue/Green Deployment

An advanced implementation can use:

```text
             ALB
              |
       +------+------+
       |             |
    Blue TG       Green TG
       |             |
      V1             V2
```

Initially:

```text
ALB → Blue → V1
```

After testing V2:

```text
ALB → Green → V2
```

If V2 fails:

```text
ALB → Blue → V1
```

This provides a fast rollback mechanism.

---

# 📅 Day 4 — ALB Path-Based Routing

## Objective

Use a single ALB DNS name to expose two different Nginx applications.

Example:

```text
ALB-DNS/ninja1
ALB-DNS/ninja2
```

---

# 🏗️ Day 4 Architecture

```text
                         Internet
                            |
                      Public IP Only
                            |
                            v
                         ALB
                       Port 80
                            |
              +-------------+-------------+
              |                           |
        /ninja1                       /ninja2
              |                           |
              v                           v
       Target Group 1              Target Group 2
              |                           |
              v                           v
       Private EC2-1               Private EC2-2
           Nginx                       Nginx
         Image-1                      Image-2
```

---

# 1. Network Design

Create/use:

```text
Public Subnet
    |
    +-- Bastion Host

Private Subnet 1
    |
    +-- Nginx EC2-1

Private Subnet 2
    |
    +-- Nginx EC2-2
```

---

# 2. Bastion Host

The Bastion Host is placed in the public subnet.

SSH:

```text
Internet
   |
   v
Public IP
   |
   v
Bastion
   |
   v
Private EC2
```

Bastion Security Group:

```text
SSH : 22
Source: YOUR_PUBLIC_IP/32
```

No public SSH access should be allowed from:

```text
0.0.0.0/0
```

---

# 3. Private Nginx Servers

Both Nginx instances remain private.

Their SSH access:

```text
Port 22
Source = Bastion Security Group
```

Therefore:

```text
Internet
   X
   |
Private Nginx
```

but:

```text
Bastion
   |
   v
Private Nginx
```

is allowed.

---

# 4. Nginx Application 1

First Nginx server should display:

```text
/ninja1
```

and show:

```text
Image-1
```

Example:

```text
http://server/ninja1
```

---

# 5. Nginx Application 2

Second Nginx server should display:

```text
/ninja2
```

and show:

```text
Image-2
```

Example:

```text
http://server/ninja2
```

---

# 6. Target Groups

Create two Target Groups:

```text
Target Group 1
    |
    +-- Nginx EC2-1

Target Group 2
    |
    +-- Nginx EC2-2
```

Health check:

```text
Protocol: HTTP
Port: 80
```

---

# 7. ALB Listener Rules

Create HTTP listener on:

```text
Port 80
```

Rule 1:

```text
IF Path = /ninja1
THEN Forward → Target Group 1
```

Rule 2:

```text
IF Path = /ninja2
THEN Forward → Target Group 2
```

Traffic:

```text
ALB-DNS/ninja1
       |
       v
Target Group 1
       |
       v
Nginx-1
       |
       v
Image-1
```

and:

```text
ALB-DNS/ninja2
       |
       v
Target Group 2
       |
       v
Nginx-2
       |
       v
Image-2
```

---

# 8. Security Groups

## ALB Security Group

Allow:

```text
HTTP : 80
Source: YOUR_PUBLIC_IP/32
```

Do not expose ALB HTTP to:

```text
0.0.0.0/0
```

if the requirement is public-IP-only access.

---

## Nginx Security Group

Allow:

```text
HTTP : 80
Source: ALB Security Group
```

Allow:

```text
SSH : 22
Source: Bastion Security Group
```

Do not allow:

```text
HTTP → 0.0.0.0/0
SSH  → 0.0.0.0/0
```

---

# 9. S3 Image Management

Maintain the webpage repository on the EC2 server.

Push updated images to the required S3 folders using AWS CLI.

Example:

```bash
aws s3 cp image1.jpg s3://<bucket>/ninja1/
aws s3 cp image2.jpg s3://<bucket>/ninja2/
```

---

# 📅 Day 5 — S3, IAM and Environment Separation

## Objective

Create a secure S3 environment with separate:

```text
prod
nonprod
```

folders.

The S3 bucket should be created in:

```text
US East (N. Virginia)
us-east-1
```

---

# 1. Create S3 Bucket

Example:

```text
<unique-bucket-name>
```

Inside the bucket:

```text
bucket/
├── prod/
└── nonprod/
```

---

# 2. Upload Images

Example:

```text
prod/
   ├── prod-image1.jpg
   └── prod-image2.jpg

nonprod/
   ├── test-image1.jpg
   └── test-image2.jpg
```

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

---

# 📅 Day 6 — CloudFront, IAM Trust Relationship and Least Privilege

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

---

# 🔐 Security Requirements

The final architecture should follow these security principles.

## EC2

* Private Nginx servers
* No unnecessary public IPs
* SSH only through Bastion
* Security Group references instead of broad CIDR rules where possible

## Bastion

```text
SSH 22
Source = YOUR_PUBLIC_IP/32
```

## ALB

```text
HTTP 80
Source = YOUR_PUBLIC_IP/32
```

## Nginx

```text
HTTP 80
Source = ALB Security Group

SSH 22
Source = Bastion Security Group
```

## S3

* Block unnecessary public access
* Use IAM policies
* Use bucket policies carefully
* Separate prod and nonprod
* Restrict IAM user access
* Use IAM Roles instead of access keys on EC2

## IAM

Follow:

```text
Least Privilege
```

---

# 🧪 Validation Checklist

## Day 1

* [ ] Nginx installed
* [ ] AMI-1 created
* [ ] V1 created
* [ ] AMI-2 created
* [ ] V2 created
* [ ] Launch Template created
* [ ] Target Group created
* [ ] ALB created
* [ ] ASG created
* [ ] Scaling policy tested
* [ ] Load test performed
* [ ] CPU metrics analyzed
* [ ] Network In analyzed
* [ ] Network Out analyzed
* [ ] ALB Request Count analyzed
* [ ] V1 → V2 upgrade tested
* [ ] V2 → V1 rollback tested

## Day 2

* [ ] Git repository cloned from EC2
* [ ] IAM Role attached to EC2
* [ ] AWS CLI verified
* [ ] No access keys stored
* [ ] Images uploaded to S3
* [ ] Nginx webpage created
* [ ] S3 images displayed

## Day 3

* [ ] Nginx health test performed
* [ ] Instance made unhealthy
* [ ] ASG detected unhealthy state
* [ ] Replacement instance launched
* [ ] Desired capacity maintained

## Day 4

* [ ] Bastion created
* [ ] Private Nginx EC2-1 created
* [ ] Private Nginx EC2-2 created
* [ ] SSH restricted
* [ ] HTTP restricted
* [ ] Target Group 1 created
* [ ] Target Group 2 created
* [ ] ALB created
* [ ] `/ninja1` tested
* [ ] `/ninja2` tested
* [ ] Image-1 displayed
* [ ] Image-2 displayed
* [ ] Images uploaded to S3

## Day 5

* [ ] S3 bucket created in us-east-1
* [ ] prod folder created
* [ ] nonprod folder created
* [ ] Images uploaded
* [ ] IAM user created
* [ ] IAM Role created
* [ ] IAM user restricted from prod
* [ ] IAM user allowed to access nonprod
* [ ] Bucket policy tested

## Day 6

* [ ] CloudFront distribution created
* [ ] S3 configured as origin
* [ ] CDN image access tested
* [ ] IAM trust relationship validated
* [ ] IAM permissions validated
* [ ] Least-privilege IAM user created
* [ ] Direct S3 access restrictions tested

---

# 📈 Expected Final Architecture

```text
                         CLIENT
                            |
                            v
                     Public IP Only
                            |
                            v
                  +-------------------+
                  |       ALB         |
                  |    Port 80        |
                  +---------+---------+
                            |
             +--------------+--------------+
             |                             |
          /ninja1                       /ninja2
             |                             |
             v                             v
     +---------------+             +---------------+
     | Private Nginx |             | Private Nginx |
     |     EC2-1     |             |     EC2-2     |
     |    Image-1    |             |    Image-2    |
     +-------+-------+             +-------+-------+
             |                             |
             +-------------+---------------+
                           |
                           v
                    +-------------+
                    |     S3      |
                    |-------------|
                    | prod/       |
                    | nonprod/    |
                    +------+------+
                           |
                           v
                    +-------------+
                    | CloudFront  |
                    |    CDN      |
                    +-------------+
                           |
                           v
                        CLIENT
```

---

# 🎯 Final Outcome

After completing this assignment, the infrastructure will demonstrate:

```text
                    HIGH AVAILABILITY
                           |
                           v
                         ALB
                           |
                           v
                         ASG
                           |
             +-------------+-------------+
             |                           |
          Nginx                       Nginx
             |                           |
             +-------------+-------------+
                           |
                      Auto Scaling
                           |
                      Health Checks
                           |
                      AMI Versioning
                           |
                   Rolling Deployment
                           |
                        Rollback
```

and:

```text
                  WEB HOSTING
                       |
                       v
                     Nginx
                       |
                       v
                      S3
                       |
                       v
                   CloudFront
                       |
                       v
                     Client
```

while maintaining:

```text
IAM
 |
 +-- Least Privilege
 |
 +-- IAM Roles
 |
 +-- Trust Relationships
 |
 +-- S3 Restrictions
 |
 +-- Private EC2
 |
 +-- Bastion Access
 |
 +-- ALB Access Restrictions
```

---

# 📝 Key AWS Services Used

| AWS Service        | Purpose                           |
| ------------------ | --------------------------------- |
| EC2                | Nginx servers                     |
| AMI                | Versioned server images           |
| Launch Template    | Instance configuration/versioning |
| Auto Scaling Group | High availability and scaling     |
| ALB                | Load balancing and path routing   |
| Target Groups      | Nginx backend registration        |
| CloudWatch         | Monitoring and scaling metrics    |
| S3                 | Image/static-object storage       |
| IAM                | Authentication and authorization  |
| IAM Role           | Secure AWS access from EC2        |
| CloudFront         | CDN and caching                   |
| VPC                | Network isolation                 |
| Security Groups    | Network access control            |
| Bastion Host       | Controlled SSH access             |
| AWS CLI            | S3 operations from EC2            |

---

# 💡 Important Implementation Principle

The assignment follows this sequence:

```text
MANUAL IMPLEMENTATION
        ↓
VALIDATION
        ↓
VERSIONING
        ↓
HIGH AVAILABILITY
        ↓
AUTO SCALING
        ↓
ROLLING DEPLOYMENT
        ↓
ROLLBACK
        ↓
SECURITY
        ↓
CDN
        ↓
AUTOMATION (OPTIONAL)
```

The manual implementation should be completed and tested first. Automation/Blue-Green deployment can then be added as an advanced enhancement.
