# Assignment 6: Kubernetes Deployments and ReplicaSets

## Objective

The objective of this assignment is to understand Kubernetes Deployments and ReplicaSets by deploying the OT-Microservices application on a Kubernetes cluster.


## Introduction

### What is a Deployment?

A Deployment is a Kubernetes resource used to manage application Pods. It helps maintain the desired number of replicas and supports rolling updates and rollbacks.

### What is a ReplicaSet?

A ReplicaSet ensures that the specified number of Pod replicas are running at all times. If a Pod fails or is deleted, the ReplicaSet creates a replacement Pod.

## Architecture

```text
Kubernetes Cluster
       |
       v
   Deployment
       |
       v
    ReplicaSet
       |
       v
      Pods
       |
       v
 OT-Microservices
```

## Implementation Steps

### Step 1: Create the Assignment Directory

```bash
mkdir -p ~/assignment-6
cd ~/assignment-6
```

### Step 2: Deploy MySQL

Create `mysql-deployment.yaml` and configure the MySQL Deployment.

Apply the manifest:

```bash
kubectl apply -f mysql-deployment.yaml
```

Verify the Deployment and ReplicaSet:

```bash
kubectl get deployments
kubectl get replicasets
kubectl get pods
```

<img width="457" height="196" alt="image" src="https://github.com/user-attachments/assets/f6823074-0005-409c-be74-0e0d7f28173b" />

### Step 3: Create MySQL Service

Create `mysql-service.yaml` to expose MySQL inside the Kubernetes cluster.

```bash
kubectl apply -f mysql-service.yaml
```

Verify the Service:

```bash
kubectl get services
kubectl get endpoints mysql
```
<img width="536" height="160" alt="image" src="https://github.com/user-attachments/assets/9700c541-c25c-41ec-82d6-b214d90b1c04" />


### Step 4: Deploy Attendance

Create `attendance-deployment.yaml` with two desired replicas.

```bash
kubectl apply -f attendance-deployment.yaml
```

Verify:

```bash
kubectl get deployment attendance
kubectl get replicasets
kubectl get pods
```
<img width="801" height="423" alt="image" src="https://github.com/user-attachments/assets/be637dc9-6d2a-47ce-9af4-34da9cd6971d" />

### Step 5: Deploy Employee

Create `employee-deployment.yaml` with two desired replicas.

```bash
kubectl apply -f employee-deployment.yaml
```

Verify:

```bash
kubectl get deployment employee
kubectl get replicasets
kubectl get pods
```

<img width="545" height="335" alt="image" src="https://github.com/user-attachments/assets/512a04d1-fab7-4fe8-9a92-48930f58512f" />

### Step 6: Deploy the Remaining Components

Create Deployment manifests for Salary, Elasticsearch, Frontend, and Webserver / Traefik as required by the application.

Apply each manifest:

```bash
kubectl apply -f salary-deployment.yaml
kubectl apply -f elasticsearch-deployment.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
```

Verify all resources:

```bash
kubectl get deployments
kubectl get replicasets
kubectl get pods
kubectl get services
```
<img width="507" height="337" alt="image" src="https://github.com/user-attachments/assets/daedc178-1811-4c49-8bab-df15c4b4e6c1" />

<img width="607" height="274" alt="image" src="https://github.com/user-attachments/assets/5af96a09-3ebd-4d2a-9a08-9ebe2627614c" />


## Conclusion

In this assignment, Kubernetes Deployments and ReplicaSets are used to manage the OT-Microservices application. The exercise demonstrates how Deployments create ReplicaSets, how ReplicaSets maintain the desired number of Pods, and how Services provide internal network connectivity.
