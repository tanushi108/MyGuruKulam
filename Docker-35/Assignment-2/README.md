# ASSIGNMENT 2: Docker Web Server

## Objective
Create a Docker image using the latest Ubuntu image, install Node.js and npm, configure an HTTP server, and serve a local HTML webpage inside a Docker container.

## Prerequisites
- Docker installed on the virtual machine.
- Basic knowledge of Docker commands.
- SSH or terminal access to the virtual machine.

## Project Structure

```text
assignment2/
├── Dockerfile
├── index.html
└── README.md
```

## Step 1: Create the Dockerfile

Create a file named `Dockerfile` and add the following instructions:

**Note:** The symlink command is included as requested. If `/usr/bin/node` already exists in the selected Ubuntu image, the symlink command may fail. In that case, check `node --version` and adjust the command accordingly.

## Step 2: Create the HTML File

Create `index.html` in the same directory as the Dockerfile.

```html
<!DOCTYPE html>
<html>
<head>
    <title>Hello Docker</title>
</head>
<body>
    <h1>Hello from Docker!</h1>
    <p>This webpage is running inside an Ubuntu container.</p>
    <p>Assignment 2 completed successfully.</p>
</body>
</html>
```

## Step 3: Build the Docker Image

Build the image and tag it as `tanushi:docker-web`.

```bash
docker build -t tanushi:docker-web .
```

Verify that the image has been created:

```bash
docker images
```

## Step 4: Run the Docker Container

Run the container and map host port 8080 to container port 8080.

```bash
docker run -d --name hello-docker -p 8080:8080 tanushi:docker-web
```

Verify the running container:

```bash
docker ps
```

## Step 5: Access the Webpage

Open a browser and visit:

```text
http://<virtualmachine_ipaddress>:8080/index.html
```

Replace `<virtualmachine_ipaddress>` with the actual IP address of your virtual machine.

To find the VM's IP address on Linux, run:

```bash
hostname -I
```

You can also test the webpage locally on the VM:

```bash
curl http://localhost:8080/index.html
```

If you are accessing the VM remotely, ensure that inbound TCP port `8080` is allowed by the VM's firewall and, if applicable, its cloud security group.

## Step 6: Check Container Logs

View the container logs:

```bash
docker logs hello-docker
```

## Step 7: Delete the Docker Container and Image

Stop the container:

```bash
docker stop hello-docker
```

Remove the container:

```bash
docker rm hello-docker
```

Remove the image:

```bash
docker rmi tanushi:docker-web
```

Verify the cleanup:

```bash
docker ps -a
docker images
```


## Conclusion

Successfully created and tested a Docker image that serves a static HTML webpage using Ubuntu, Node.js, npm, and `http-server`. The container was configured with port mapping and cleaned up after verification.
