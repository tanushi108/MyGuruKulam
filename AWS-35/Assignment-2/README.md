Assignment 2 – Deployment Strategies with Amazon S3
📌 Objective

Learn and implement different application deployment strategies using Amazon EC2, Auto Scaling Group (ASG), Load Balancer, AMIs, and Amazon S3 for static assets and deployment artifacts.

🚀 Deployment Strategies

This assignment covers:

Recreate Deployment
Rolling Deployment
Blue-Green Deployment
A/B Deployment
Canary Deployment
1. Recreate Deployment
Implementation
Launch an EC2 instance.
Install and configure the application.
Create an AMI from the configured EC2 instance.
Use the AMI to recreate the application on another EC2 instance.
Store static assets such as:
Images
CSS
JavaScript
in an Amazon S3 bucket.
Configure the application/webpage to retrieve assets directly from S3.
Flow
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
2. Rolling Deployment
Implementation
Create a Launch Template for the application.
Create an Auto Scaling Group.
Configure minimum and maximum instance counts.
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
3. Blue-Green Deployment ⭐ Good To Do

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
4. A/B Deployment

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
