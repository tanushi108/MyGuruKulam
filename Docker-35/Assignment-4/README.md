# Assignment-4: OT-Microservices Using Docker Compose

## Objective

The objective of this assignment is to deploy the OT-Microservices application using Docker Compose and explore its advanced features, including service scaling, container recreation, and selective service execution.

**Repository:** https://github.com/opstree/OT-Microservices


## Step 1: Clone and Run the Application

### Clone the repository

```bash
git clone https://github.com/opstree/OT-Microservices.git
cd OT-Microservices
ls -la
```

<img width="965" height="591" alt="image" src="https://github.com/user-attachments/assets/32ff6394-b061-40c8-a3a5-4b1a725ff37f" />


### Build and start the application

```bash
docker compose build
```

<img width="1365" height="679" alt="image" src="https://github.com/user-attachments/assets/900a1b1f-a499-4b3a-ba31-9a6deefc3a98" />

<img width="1352" height="669" alt="image" src="https://github.com/user-attachments/assets/25a8bc39-e4b1-4e98-b1c3-4be5b92a48e5" />

### Access the application

Check the published ports:

```bash
docker compose ps
```

Open the frontend URL using the host port published by the Compose configuration, for example:

```text
http://localhost
```

<img width="1365" height="415" alt="image" src="https://github.com/user-attachments/assets/0e372bba-daff-4bd8-8c62-a43d60583e2a" />

<img width="1365" height="265" alt="image" src="https://github.com/user-attachments/assets/71d7e2cb-b00b-405f-b39e-4fc04a5a15cc" />

<img width="1365" height="719" alt="image" src="https://github.com/user-attachments/assets/f931d485-98bb-4d7e-ab2e-8bf21d66c47b" />

## Step 2: Run the Application Without Local Source Code

The goal is to remove the application source code while keeping the application runnable through Docker images.

### 1. Build and publish the images

Before deleting the source code, identify the application images:

```bash
docker compose config --images
docker images
```

Tag your locally built application images with a registry name, such as Docker Hub:

```bash
docker login
docker tag ot-microservices-empms-attendance:latest tanushirana875826/empms-attendance:latest
docker push tanushirana875826/empms-attendance:latest
```
<img width="1363" height="644" alt="image" src="https://github.com/user-attachments/assets/6a2cf5d1-f042-4795-8ffa-22a5b2fad8c4" />

<img width="1123" height="157" alt="image" src="https://github.com/user-attachments/assets/5de37e47-fdff-42c2-81f3-b8a36a8ac4d7" />

Repeat this for each custom application image. Use the exact image names from your Compose configuration.

### 2. Prepare a deployment-only directory

Create a separate directory containing only the deployment files:

```bash
mkdir -p ~/ot-deployment
```

Copy the Compose file and any required environment/configuration files into it. Replace local `build:` definitions with the corresponding published `image:` references.

Example:

```yaml
services:
  empms-employee:
    image: <dockerhub-username>/<employee-image>:<tag>
```

Apply the same image-reference approach to the other custom services. Preserve the repository's required service settings, networks, volumes, environment variables, and dependencies.

### 3. Test without the source directory

After verifying that the deployment-only copy works, remove the original cloned source directory:

```bash
cd ~
rm -rf OT-Microservices
cd ~/ot-deployment
docker compose pull
docker compose up -d
docker compose ps
```




## Step 3: Run the Application on other System

The buddy should not need to clone the Git repository or build the application from source.

### 1. Share the deployment files

Share the deployment-only directory containing:

- Docker Compose YAML file
- Required `.env` template or environment configuration
- Any required configuration files
- Instructions for pulling the images

Do not share passwords, tokens, database credentials, or other secrets in a public repository.

### 2. Install Docker

On the buddy's system, verify:

```bash
docker --version
docker compose version
```

### 3. Authenticate and pull the images

If the images are private:

```bash
docker login
```

Then run:

```bash
cd ot-deployment
docker compose pull
docker compose up -d
docker compose ps
```

### 4. Verify the application

```bash
docker compose logs
docker compose ps
```

Open the frontend using the published port.

**Expected result:** The buddy runs the application using the shared Compose configuration and published images, without cloning the source repository.

## Step 4: High Availability for Employee, Salary, and Attendance

Docker Compose supports multiple replicas of stateless services. For this assignment, scale Employee, Salary, and Attendance to multiple containers.

### 1. Configure the services

Ensure the three services use published images and do not require unique host ports for every replica. For example:

```yaml
services:
  empms-employee:
    image: <dockerhub-username>/<employee-image>:<tag>
    # Preserve the required environment, network and dependency settings.

  empms-salary:
    image: <dockerhub-username>/<salary-image>:<tag>
    # Preserve the required environment, network and dependency settings.

  empms-attendance:
    image: <dockerhub-username>/<attendance-image>:<tag>
    # Preserve the required environment, network and dependency settings.
```

Use the existing Compose configuration as the source of truth for all application-specific settings.

### 2. Scale the services

```bash
docker compose up -d --scale empms-employee=2 --scale empms-salary=2 --scale empms-attendance=2
```

Verify the replicas:

```bash
docker compose ps
```

You should see multiple containers for each of the three services.

### 3. Test replica recreation

Inspect the running containers:

```bash
docker ps
```

Stop one Employee replica by its actual container name or ID:

```bash
docker stop <employee-container-name-or-id>
```

Then inspect the service again:

```bash
docker compose ps
```

Docker Compose does not automatically replace a manually stopped replica in every situation. To restore the desired replica count, run:

```bash
docker compose up -d --scale empms-employee=2
```

Repeat the test for Salary and Attendance.

### High-availability considerations

- Multiple replicas provide additional service instances.
- Stateless services are easier to scale horizontally.
- A load balancer or application-aware routing layer is needed to distribute requests between replicas.
- Health checks help detect unhealthy containers but do not, by themselves, guarantee automatic recovery.
- A single Docker host remains a single point of failure. Docker Compose on one host is not equivalent to multi-node orchestration with Docker Swarm or Kubernetes.

**Expected result:** Employee, Salary, and Attendance can run multiple replicas and can be restored to their configured replica count.

## Bonus: Run Only Attendance and MySQL

Docker Compose allows selected services to be started without explicitly starting every service in the project.

### 1. Start the required services

From the directory containing the Compose file, run:

```bash
docker compose up -d empms-db empms-attendance
```

Here:

- `empms-db` is the MySQL/database service.
- `empms-attendance` is the Attendance service.

Compose may also start dependencies declared in the configuration.

### 2. Verify the running services

```bash
docker compose ps
```

To view logs:

```bash
docker compose logs empms-db
docker compose logs empms-attendance
```



## Conclusion

This assignment demonstrates Docker Compose application deployment, image distribution, deployment without source code, service scaling, and selective service startup. It also highlights the distinction between running multiple replicas and achieving true high availability across multiple hosts.
