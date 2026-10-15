<!-- <img width="846" height="169" alt="image" src="https://github.com/user-attachments/assets/add12d89-7ee7-4f8a-84fe-b95558071b4e" />

<img width="1365" height="530" alt="image" src="https://github.com/user-attachments/assets/f77a3426-4a4b-4998-b215-94a59e61e438" />

<img width="422" height="157" alt="image" src="https://github.com/user-attachments/assets/d42eefd5-cfb8-486d-a698-900217ca35de" />

<img width="510" height="83" alt="image" src="https://github.com/user-attachments/assets/a6eefbaf-39ce-4a48-9011-ed8eda96c8df" />


<img width="779" height="236" alt="image" src="https://github.com/user-attachments/assets/02bec462-c603-4dd3-9388-6da25ec7c0b2" /> -->


---
# Assignment 5: Deploy OT-Microservices on Kubernetes

## Objective

Deploy the OT-Microservices application on a Kubernetes cluster using Kubernetes Pods, Deployments, and Services. Verify that the application components are running and that the required services can communicate with each other.

## Technologies Used

* Kubernetes
* `kubectl`
* Killercoda Kubernetes Playground
* Docker Hub
* YAML manifests
* MySQL
* Elasticsearch

## Docker Hub Images

The following images are used for the application components:

| Component     | Docker Image                                |
| ------------- | ------------------------------------------- |
| MySQL         | `tanushirana875826/empms-db:latest`         |
| Attendance    | `tanushirana875826/empms-attendance:latest` |
| Elasticsearch | `tanushirana875826/empms-es:latest`         |
| Salary        | `tanushirana875826/empms-salary:latest`     |
| Employee      | `tanushirana875826/empms-employee:latest`   |
| Frontend      | `tanushirana875826/empms-frontend:latest`   |
| Kibana        | `tanushirana875826/empms-kibana:8.4.3`      |
| Traefik       | `tanushirana875826/empms-traefik:v3.3`      |

## Assignment Tasks

### Task 1: MySQL and Attendance

**Objective:** Deploy the MySQL and Attendance components.

Steps:

1. Create a MySQL Pod or Deployment.
2. Configure the required environment variables.
3. Expose MySQL through a Kubernetes Service.
4. Deploy the Attendance component.
5. Configure Attendance to connect to MySQL.
6. Verify the Pods and Services.

Validation commands:

```bash

kubectl apply -f mysql.yaml
kubectl apply -f mysql-service.yaml
kubectl get pods
kubectl get services
```
<img width="527" height="215" alt="image" src="https://github.com/user-attachments/assets/7133195f-6e39-4f56-af5f-8f36296b03dc" />

<img width="434" height="121" alt="image" src="https://github.com/user-attachments/assets/575a463d-7a82-4499-a17c-71fc3aae3551" />

```bash
kubectl apply -f attendance.yaml
kubectl apply -f attendance-service.yaml
kubectl get pods
kubectl get services
```

<img width="519" height="330" alt="image" src="https://github.com/user-attachments/assets/f4e311ab-01b9-4f08-94e3-d97bb8d8a506" />

### Task 2: Elasticsearch, Salary, and Employee

**Objective:** Deploy Elasticsearch and connect the Salary and Employee components to it.

Steps:

1. Deploy Elasticsearch.
2. Configure Elasticsearch for single-node operation.
3. Expose Elasticsearch through a Kubernetes Service.
4. Deploy the Salary component.
5. Configure Salary to connect to Elasticsearch.
6. Deploy the Employee component.
7. Configure Employee to connect to Elasticsearch.
8. Verify the Pods, Services, and application logs.

Validation commands:

```bash
kubectl apply -f es.yaml
kubectl apply -f es-service.yaml
kubectl get pods
kubectl get services
```
<img width="558" height="301" alt="image" src="https://github.com/user-attachments/assets/4a6c1cf4-cda1-4a71-9e11-1f669f7066bf" />

```bash
kubectl apply -f salary.yaml
kubectl apply -f salary-service.yaml
kubectl get pods
kubectl get services
```
<img width="440" height="119" alt="image" src="https://github.com/user-attachments/assets/5776aead-9f08-4d76-9648-6b77b01be84c" />

```bash
kubectl apply -f employee.yaml
kubectl apply -f employee-service.yaml
kubectl get pods
kubectl get services
```

<img width="418" height="65" alt="image" src="https://github.com/user-attachments/assets/4f8c95a4-5c3b-4a44-80b1-1fcc9b9f1368" />


### Task 3: Frontend and Webserver

**Objective:** Deploy the frontend and webserver components.

Steps:

1. Deploy the Frontend component.
2. Deploy the Webserver component using the appropriate image and configuration.
3. Create the required Kubernetes Services.
4. Configure access to the frontend.
5. Verify that the Pods are running and the application is reachable.

Validation commands:

```bash
kubectl apply -f frontend.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f webserver.yaml
kubectl apply -f webserver-service.yaml
kubectl get deployments
kubectl get pods
kubectl get services
```

<img width="693" height="292" alt="image" src="https://github.com/user-attachments/assets/b63b37bd-5967-429c-afc3-51f5f181bb94" />


## Conclusion

This assignment demonstrates deploying a multi-component application on Kubernetes, managing workloads with Deployments, exposing applications through Services, configuring inter-service communication, and validating the health of deployed components.
