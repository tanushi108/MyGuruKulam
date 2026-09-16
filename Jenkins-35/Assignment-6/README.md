# Assignment 6 - Ansible Shared Library in Jenkins

## Objective

Create a Jenkins Shared Library for Kubernetes/EKS automation using Ansible.

The Shared Library performs the following steps:

1. Clone
2. User Approval
3. Playbook Execution
4. Notification

The required inputs are provided through a configuration file.

---

## Technologies Used

- Jenkins
- Jenkins Shared Library
- Ansible
- AWS EKS
- eksctl
- kubectl
- GitHub
- Slack

---

## Project Structure

```text
EKS-Jenkins/
├── vars/
│   └── eksAutomation.groovy
└── README.md

```
The Ansible project is maintained separately:

eks-automation/
├── ansible.cfg
├── inventory
├── site.yml
├── group_vars/
│   └── all.yml
├── eks-cluster.yaml
└── roles/
    └── eks/
        ├── defaults/
        │   └── main.yml
        ├── tasks/
        │   └── main.yml
        └── templates/
            └── eks-cluster.yaml.j2

## Shared Library

The Jenkins Shared Library is configured in Jenkins with:

Name: devops-shared-library
Branch: main

The library is used in the Jenkinsfile:

@Library('devops-shared-library') _

The Shared Library function is:

eksAutomation()
Configuration

The required inputs are passed through a configuration file.

Example:

SLACK_CHANNEL_NAME: build-status
ENVIRONMENT: learning
CODE_BASE_PATH: .
ACTION_MESSAGE: "EKS automation build completed"
KEEP_APPROVAL_STAGE: true
AWS_REGION: ap-south-1
Configuration Parameters
Parameter	Description
SLACK_CHANNEL_NAME	Slack channel for build notifications
ENVIRONMENT	Target environment
CODE_BASE_PATH	Path of the Ansible code
ACTION_MESSAGE	Slack notification message
KEEP_APPROVAL_STAGE	Enables or disables user approval
AWS_REGION	AWS region
Pipeline Flow
Jenkins
   |
   v
Shared Library
   |
   v
Read Configuration
   |
   v
Clone
   |
   v
User Approval
   |
   v
Playbook Execution
   |
   v
AWS EKS
   |
   v
Notification
## 1. Clone

The Shared Library clones the Ansible repository from GitHub.

Repository:

https://github.com/tanushi108/eks-automation.git

Branch:

main

The repository contains the Ansible playbook and EKS configuration.

## 2. User Approval

Before executing the EKS operation, Jenkins asks for user approval.

Example:

EKS Automation

Operation: CREATE
Cluster: my-cluster
Environment: learning

Do you want to continue?

The approval stage is controlled by:

KEEP_APPROVAL_STAGE: true

If approval is enabled, the pipeline waits for user confirmation before executing the playbook.

## 3. Playbook Execution

After approval, Jenkins executes the Ansible playbook.

Example:

ansible-playbook site.yml \
  -i inventory \
  -e "operation=create" \
  -e "eks_cluster_name=my-cluster"

The supported operations are:

create
verify
destroy
Create

Creates the EKS cluster using Ansible and eksctl.

Jenkins
   |
   v
Ansible
   |
   v
eksctl
   |
   v
AWS EKS
Verify

Verifies the EKS cluster status.

Example:

aws eks describe-cluster \
  --name my-cluster \
  --region ap-south-1

Kubernetes nodes can also be checked using:

kubectl get nodes
Destroy

Deletes the EKS cluster using:

eksctl delete cluster

## 4. Notification

After playbook execution, Jenkins sends the build status to Slack.

Slack channel:

SLACK_CHANNEL_NAME: build-status

Example successful notification:

EKS Automation

Operation: CREATE
Environment: learning
Status: SUCCESS

EKS automation completed successfully.

Example failed notification:

EKS Automation

Operation: CREATE
Environment: learning
Status: FAILED
Ansible Configuration

AWS region:

ap-south-1

EKS configuration:

Kubernetes Version: 1.35
Instance Type: t3.small
Minimum Nodes: 1
Desired Nodes: 1
Maximum Nodes: 2
Volume Size: 20 GB
Volume Type: gp3

The configuration is intended for a learning environment.

Jenkins AWS Credentials

AWS credentials are stored in Jenkins Credentials and are injected during pipeline execution.

Example credential IDs:

aws-access-key
aws-secret-key

The AWS credentials are not stored directly in the Git repository.

They are used by the Shared Library during Ansible execution.

Jenkinsfile

Example Jenkinsfile:

@Library('devops-shared-library') _

pipeline {

    agent any

    stages {

        stage('EKS Automation') {

            steps {

                eksAutomation()
            }
        }
    }
}

The Shared Library handles the complete workflow.

EKS Operations

The Shared Library supports three operations:

Operation	Purpose
create	Create EKS cluster
verify	Verify EKS cluster
destroy	Delete EKS cluster
Complete Workflow
                Jenkins
                   |
                   v
          Jenkins Shared Library
                   |
                   v
            Read Configuration
                   |
                   v
                Clone
                   |
                   v
            User Approval
                   |
                   v
         Ansible Playbook
                   |
          +--------+--------+
          |        |        |
          v        v        v
       CREATE   VERIFY   DESTROY
          |        |        |
          +--------+--------+
                   |
                   v
                AWS EKS
                   |
                   v
            Slack Notification
Assignment Requirements

The following Assignment 6 requirements are implemented:

Clone
User Approval
Playbook Execution
Notification
Configuration through configuration file
Jenkins Shared Library
Ansible based Kubernetes/EKS automation
