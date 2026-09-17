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


## Project Structure

```text
EKS-Jenkins/
├── vars/
│   └── eksAutomation.groovy
└── README.md

```
The Ansible project is maintained separately:
```
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
```

## Shared Library

The Jenkins Shared Library is configured in Jenkins with:

Name: devops-shared-library
Branch: main

<img width="1183" height="408" alt="image" src="https://github.com/user-attachments/assets/c58c8ea0-f64e-4e59-a65f-b1fa7588a417" />



<img width="1123" height="534" alt="image" src="https://github.com/user-attachments/assets/55582f8d-11b0-41ef-b63e-bc36abf5a5b8" />


## 1. Clone

The Shared Library clones the Ansible repository from GitHub.

Repository:

https://github.com/tanushi108/eks-automation.git

Branch:

main

The repository contains the Ansible playbook and EKS configuration.

## 2. Parameters and User approval

Before executing the EKS operation, Jenkins asks for user approval.

Example:

EKS Automation

Operation: CREATE
Cluster: my-cluster

Do you want to continue?

The approval stage is controlled by:

KEEP_APPROVAL_STAGE: true

If approval is enabled, the pipeline waits for user confirmation before executing the playbook.

<img width="1074" height="461" alt="image" src="https://github.com/user-attachments/assets/1ef4f045-192c-4afe-9ac7-29be4d075871" />

<img width="1365" height="591" alt="image" src="https://github.com/user-attachments/assets/99d960c9-f034-4e9a-8512-e29da9f93cad" />


## 3. Playbook Execution

After approval, Jenkins executes the Ansible playbook.

Example:

ansible-playbook site.yml \
  -i inventory \
  -e "operation=create" \
  -e "eks_cluster_name=my-cluster"

<img width="1101" height="570" alt="image" src="https://github.com/user-attachments/assets/812aa9b6-4742-4fb6-af3f-9c4670d6c5d7" />


<img width="1362" height="584" alt="image" src="https://github.com/user-attachments/assets/c4295622-1185-489d-9273-abbda6b1b796" />



The supported operations are:

create
verify
destroy


Example:

aws eks describe-cluster \
  --name my-cluster \
  --region ap-south-1

<img width="1313" height="600" alt="image" src="https://github.com/user-attachments/assets/c9f8cb98-3aac-49e6-92ae-390b3f01fcd6" />


Destroy

Deletes the EKS cluster using:

eksctl delete cluster

<img width="1361" height="423" alt="image" src="https://github.com/user-attachments/assets/9e905791-bcc5-4755-95b7-a1ce6599e14f" />

<img width="1365" height="559" alt="image" src="https://github.com/user-attachments/assets/cd245e21-3891-427f-9328-aa9c04804f92" />


## 4. Notification

After playbook execution, Jenkins sends the build status to Slack and email.

<img width="1030" height="406" alt="image" src="https://github.com/user-attachments/assets/2b558714-ad61-4a2a-9825-adf9a3c4deb6" />

<img width="1126" height="406" alt="image" src="https://github.com/user-attachments/assets/2ff23aa9-aec3-43e7-bfd9-84b9d8ae5714" />


<img width="1072" height="392" alt="image" src="https://github.com/user-attachments/assets/fdd09076-084e-451d-9cc6-bc8cb879f961" />


# Conclusion

This assignment successfully implemented an automated EKS cluster management pipeline using Jenkins and a shared library. It includes parameterized create, verify, and destroy operations, user approval, and automated Slack and email notifications on successful builds.
