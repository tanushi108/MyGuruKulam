# Assignment-01: Load Balancer & Auto Scaling Group

##  Objective

The goal of this assignment is to design and implement a cloud infrastructure that supports the deployment of a **Spring 3 Hibernate application**.

The infrastructure is designed to provide:

- High Availability
- Scalability
- Security
- Private application servers
- Load balancing
- Automatic scaling
- Secure internet access for private servers

---

## VPC Configuration

VPC Name:

assignment-01-vpc

CIDR:

10.0.0.0/16

## Public Subnets
### Public Subnet A
```
Name: assignment-01-public-a
CIDR: 10.0.1.0/24
Availability Zone: ap-south-1a
```
### Public Subnet B
```
Name: assignment-01-public-b
CIDR: 10.0.2.0/24
Availability Zone: ap-south-1b
```

## Private Subnets

### Private Subnet A
```
Name: assignment-01-private-a
CIDR: 10.0.11.0/24
Availability Zone: ap-south-1a
```
### Private Subnet B
```
Name: assignment-01-private-b
CIDR: 10.0.12.0/24
Availability Zone: ap-south-1b
```
Application EC2 instances are deployed inside the private subnets.

<img width="1162" height="274" alt="image" src="https://github.com/user-attachments/assets/ca6a23e0-bd36-4b60-bfda-86e4f21a1c4b" />


## Internet Gateway

Internet Gateway:

assignment-01-igw

The Internet Gateway is attached to the VPC.

It provides internet connectivity for resources in the public subnets.

Public route:

0.0.0.0/0 → Internet Gateway

<img width="1188" height="331" alt="image" src="https://github.com/user-attachments/assets/2cb40150-acbb-40e6-81f5-439e0781fa30" />


### NAT Gateway

NAT Gateway:

assignment-01-nat

Elastic IP:

assignment-01-nat-eip

The NAT Gateway is deployed in the public subnet.

Private subnet route:

0.0.0.0/0 → NAT Gateway

<img width="1198" height="445" alt="image" src="https://github.com/user-attachments/assets/c34aea97-e374-4d5e-9576-01743ba86af5" />

## Security Groups

Two Security Groups are used.

ALB Security Group
```
Name:
assignment-01-alb-sg
Inbound Rules
Protocol	Port	Source
HTTP	80	0.0.0.0/0
Outbound
All traffic
```
The ALB accepts HTTP traffic from the internet.

<img width="1365" height="530" alt="image" src="https://github.com/user-attachments/assets/bdb3356c-21b3-4f95-924e-241c0f4fd082" />

## Application Security Group
```
Name:
assignment-01-app-sg
Inbound Rules
Protocol	Port	Source
TCP	8080	assignment-01-alb-sg
Outbound
All traffic

```
The application servers accept traffic only from the Application Load Balancer.

<img width="1365" height="453" alt="image" src="https://github.com/user-attachments/assets/73560cf9-bf66-4449-9fcd-ac98f1483bd0" />



## Application Load Balancer
```
Name:
assignment-01-alb
Type:
Application Load Balancer
Scheme:
Internet-facing
IP Address Type:
IPv4
The ALB is deployed across:
assignment-01-public-a
assignment-01-public-b
Listener
HTTP : 80
```
The listener forwards requests to the application Target Group.
<img width="1364" height="579" alt="image" src="https://github.com/user-attachments/assets/8edd5a24-c992-40d1-973a-b2aaa87ff368" />


## Target Group
```
Target Group:
assignment-01-tg
Target Type:
Instances
Protocol:
HTTP
Port:
8080
Health Check:
Protocol: HTTP
Port: Traffic Port
Path: /Spring3HibernateApp/
```
The ALB uses this health check to determine whether an application server is healthy.

<img width="1365" height="568" alt="image" src="https://github.com/user-attachments/assets/cff9a1bb-1e61-4480-91be-e22748bab496" />


## Auto Scaling Group

Auto Scaling Group:
```
assignment-01-asg

The ASG uses the Launch Template:
assignment-01-launch-template
Capacity
Minimum: 2
Desired: 2
Maximum: 4

The application servers are distributed across the private subnets:

assignment-01-private-a
assignment-01-private-b
```
This allows application instances to run across multiple Availability Zones.

<img width="1356" height="577" alt="image" src="https://github.com/user-attachments/assets/b5cbb332-ebe9-43a5-bf68-54258ac4f88c" />

## Launch Template

Launch Template:

assignment-01-launch-template

The Launch Template defines the configuration used by the Auto Scaling Group.

<img width="1203" height="505" alt="image" src="https://github.com/user-attachments/assets/b7f4867d-f7c7-4aae-9b3b-6690c3dd6e05" />


## IAM / SSM

An IAM role is attached to the EC2 instances:
```
assignment-01-ec2-role
The role includes:

AmazonSSMManagedInstanceCore

AWS Systems Manager Session Manager can be used to connect to private EC2 instances without requiring:

Public IP
SSH port 22
Bastion host
```

<img width="1285" height="602" alt="image" src="https://github.com/user-attachments/assets/192add32-ee1f-4b46-986d-661f1828390b" />

# Check Target Health

AWS Console:

EC2
→ Target Groups
→ assignment-01-tg
→ Targets

Expected:

Healthy

<img width="1174" height="322" alt="image" src="https://github.com/user-attachments/assets/c1f4c33b-a8a1-4072-80b2-8318f979c8a1" />


# Test Through ALB

Open:
```
http://assignment-01-alb-195736164.ap-south-1.elb.amazonaws.com/Spring3HibernateApp/
```

<img width="1365" height="420" alt="image" src="https://github.com/user-attachments/assets/d41174a0-cb77-4cdd-b41e-946e66bf2a0f" />


# Conclusion
This assignment demonstrates the deployment of a scalable and highly available web application architecture on AWS.

The final infrastructure separates public and private resources, exposes the application through an internet-facing Application Load Balancer, keeps application EC2 instances in private subnets, provides outbound connectivity through a NAT Gateway, and uses Auto Scaling for availability and scalability.

The application environment was tested independently before being packaged into a custom AMI and used through the Launch Template and Auto Scaling Group.
