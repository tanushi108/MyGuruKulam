# Assignment 2 – Deployment Strategies with Amazon S3
## Objective

Learn and implement different application deployment strategies using Amazon EC2, Auto Scaling Group (ASG), Load Balancer, AMIs, and Amazon S3 for static assets and deployment artifacts.

### Deployment Strategies

This assignment covers:

Recreate Deployment
Rolling Deployment
Blue-Green Deployment
A/B Deployment
Canary Deployment

## 1. Recreate Deployment

### Implementation
Launch an EC2 instance.

Install and configure the application.

<img width="1160" height="325" alt="image" src="https://github.com/user-attachments/assets/954b7592-fa5c-43cf-9cef-af26c818921f" />


Create an AMI from the configured EC2 instance.

<img width="1236" height="534" alt="image" src="https://github.com/user-attachments/assets/9fa5d9d6-a5a6-4b8c-896c-324254f43e79" />

Use the AMI to recreate the application on another EC2 instance.

<img width="1344" height="598" alt="image" src="https://github.com/user-attachments/assets/3a2a2663-55aa-44ea-b092-939ac2d7139a" />

<img width="1177" height="169" alt="image" src="https://github.com/user-attachments/assets/12235f66-a506-498e-abb2-cbb8e773c212" />

Store static assets such as:
HTML file
CSS
JavaScript
in an Amazon S3 bucket.

<img width="1365" height="509" alt="image" src="https://github.com/user-attachments/assets/fdeb4c3a-8ba0-46b9-80d8-3ea37f86d964" />

Configure the application/webpage to retrieve assets directly from S3.
Flow
```
EC2 Instance
     ↓
Application
     ↓
Create AMI
     ↓
New EC2 Instance
     ↓
Application Recreated
     ↓
Static Assets → Amazon S3
```

<img width="1365" height="411" alt="image" src="https://github.com/user-attachments/assets/ed578a22-1c2a-4110-a321-9ab6783b24ad" />

<img width="1365" height="314" alt="image" src="https://github.com/user-attachments/assets/ef7109c4-8b6b-439e-8e64-60957ca34562" />

## 2. Rolling Deployment

### Implementation

Create a Launch Template for the application.
Create an Auto Scaling Group.

<img width="1344" height="569" alt="image" src="https://github.com/user-attachments/assets/69794f2e-b1d9-4c25-816c-0a16aef8401a" />

Configure minimum and maximum instance counts.

<img width="443" height="369" alt="image" src="https://github.com/user-attachments/assets/73314371-881c-4871-815a-d8d902345c8e" />

Deploy the initial application version.

Create a new Launch Template version containing the updated application.
Update the ASG to use the new version.
Perform an Instance Refresh to gradually replace old instances.
Store deployment artifacts in Amazon S3.
Flow
Old Version
   ↓
ASG
   ↓
EC2 EC2 EC2
   ↓
New Launch Template Version
   ↓
Instance Refresh
   ↓
New Version


## 3. Blue-Green Deployment ⭐ Good To Do

Create two separate environments:

             Load Balancer
                  |
          -----------------
          |               |
       BLUE             GREEN
     Version 1         Version 2
Implementation
Create the Blue environment with the current application.
Create the Green environment with the new application version.
Test the Green environment.
Use a Load Balancer to direct traffic to the required environment.
Store configuration files or environment-specific assets in S3.
Switch traffic from Blue → Green after validation.

## 4. A/B Deployment

A/B deployment sends different users or traffic segments to different application versions.

              Load Balancer
                   |
            --------------
            |            |
           V1            V2
           A             B
Example
Version A → 50% traffic
Version B → 50% traffic

Monitor application behavior and user interaction for both versions.

5. Canary Deployment ⭐ Good To Do

Deploy the new version to only a small portion of the infrastructure first.

             ASG
              |
       ----------------
       |              |
    Version 1      Version 2
    90% traffic    10% traffic
Implementation
Keep most instances on the stable version.
Deploy the new version to a small subset of instances.
Monitor:
CPU utilization
Network traffic
Application errors
Response behavior
Store logs/metrics or deployment information in S3.
Gradually increase traffic if the new version performs as expected.
🪣 Amazon S3 Usage

S3 is used for:

Static Assets
images/
css/
js/
Deployment Artifacts
application-v1/
application-v2/
Configuration
config/
environment/
Logs / Metrics
logs/
metrics/
🛠 AWS Services Used
Service	Purpose
EC2	Application servers
AMI	Application/server image
Launch Template	Instance configuration
Auto Scaling Group	Scaling and instance management
ALB	Traffic distribution
S3	Assets, artifacts, configuration and logs
CloudWatch	Monitoring
IAM	Access control
📊 Deployment Strategy Comparison
Strategy	Main Idea
Recreate	Replace old environment with new one
Rolling	Gradually replace old instances
Blue-Green	Maintain two environments and switch traffic
A/B	Send different traffic segments to different versions
Canary	Release new version to a small subset first
✅ Assignment Outcome

By completing this assignment, we understand how to:

Create and use AMIs.
Deploy applications on EC2.
Use S3 for static assets and deployment artifacts.
Configure ASG for scalable deployments.
Perform Rolling Deployments.
Understand Blue-Green, A/B, and Canary deployment strategies.
Use Load Balancers for traffic management.
Monitor deployments using CloudWatch.

AWS Region: ap-south-1 (Mumbai)
Deployment focus: EC2 + ASG + ALB + S3
