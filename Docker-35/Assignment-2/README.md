# ASSIGNMENT 2: Docker Web Server

## Objective
Create a Docker image using the latest Ubuntu image, install Node.js and npm, configure an HTTP server, and serve a local HTML webpage inside a Docker container.


## Step 1: Create the Dockerfile

Create a file named `Dockerfile` and add the following instructions:


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
    <h2>Assignment 2 - Tanushi</h2>
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
<img width="1362" height="648" alt="image" src="https://github.com/user-attachments/assets/3cc4f5c8-6338-4f17-9cd3-98367cd1d4bf" />

## Step 4: Run the Docker Container

Run the container and map host port 8080 to container port 8080.

```bash
docker run -d --name hello-docker -p 8086:8080 tanushi:docker-web
```

Verify the running container:

```bash
docker ps
```

<img width="1362" height="163" alt="image" src="https://github.com/user-attachments/assets/c4399c53-5beb-4114-b8fd-b9ac833f6a3f" />

## Step 5: Access the Webpage

Open a browser and visit:

```text
http://172.31.129.36:8086/index.html
```

<img width="1365" height="246" alt="image" src="https://github.com/user-attachments/assets/b62aedab-0eeb-440f-99d8-ce7381ff18fd" />

```bash
curl http://localhost:8086/index.html
```

<img width="799" height="235" alt="image" src="https://github.com/user-attachments/assets/a9bed59e-a48f-4a74-a061-269d47e52be6" />


## Step 6: Delete the Docker Container and Image

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

<img width="777" height="255" alt="image" src="https://github.com/user-attachments/assets/bbd361e7-4260-48d8-aa24-6fd04a29a553" />



## Conclusion

Successfully created and tested a Docker image that serves a static HTML webpage using Ubuntu, Node.js, npm, and `http-server`. The container was configured with port mapping and cleaned up after verification.
