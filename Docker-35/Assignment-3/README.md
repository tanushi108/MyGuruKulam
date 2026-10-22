# Assignment 3 — Docker with Alpine Linux

## Objective

Create a simple Node.js application using an Alpine Linux Docker image. Build the Docker image and tag it as `hello:v0.1`.

## Step 1: Create `index.js`

Create a file named `index.js` with the following code:

```javascript
var os = require("os");
var hostname = os.hostname();

console.log("hello from " + hostname);
```

## Step 2: Create the Dockerfile

Create a file named `Dockerfile`:

```dockerfile
FROM alpine:latest

LABEL maintainer="Tanushi"

RUN apk update && apk add --no-cache nodejs

COPY . /app

WORKDIR /app

CMD ["node", "index.js"]
```


## Step 3: Build the Docker Image

Run the following command in the directory containing the Dockerfile:

```bash
docker build -t hello:v0.1 .
```

<img width="897" height="682" alt="image" src="https://github.com/user-attachments/assets/420996cc-84a7-404e-b3c7-3bdbabd17429" />

Verify the image:

```bash
docker images
```

Expected image name and tag:

```text
hello    v0.1
```

## Step 4: Run the Container

```bash
docker run --rm hello:v0.1
```

Example output:

```text
hello from 8a1b2c3d4e5f
```

The hostname will vary depending on the container.

## Step 5: Verify the Image

```bash
docker image inspect hello:v0.1
```

<img width="1235" height="143" alt="image" src="https://github.com/user-attachments/assets/2d4a46b2-1a3a-410e-9610-c6e4361a5d9c" />

Check the configured command:

```bash
docker image inspect hello:v0.1 --format '{{json .Config.Cmd}}'
```

Expected output:

```text
["node","index.js"]
```

<img width="1009" height="50" alt="image" src="https://github.com/user-attachments/assets/48a77cfb-45df-4f63-baab-cb3ea8007502" />


## Conclusion

In this assignment, I successfully created a simple Node.js application using Alpine Linux as the base Docker image. I installed Node.js using the Alpine package manager (apk), configured the Dockerfile, and built the image with the tag hello:v0.1
