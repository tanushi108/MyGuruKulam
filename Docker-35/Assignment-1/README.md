# Docker Assignment 1

## Part 1: Host a Website Using Docker with Time-Based Responses

### Objective

Create a Dockerized website that:

- Is accessible through a team domain, such as `mohan.ntd.com`.
- Displays the user's name between 10:00 AM and 12:00 PM.
- Displays the buddy's name between 4:00 PM and 6:00 PM.
- Does not serve the greeting outside these intervals.

### 1. Create the project structure

```bash
mkdir -p ~/assignment1/part1
cd ~/assignment1/part1
```

Create these files:

```text
part1/
├── Dockerfile
└── app.py
```

### 2. Create the Python application

Create `app.py`:

### 3. Create the Dockerfile

Create a file named `Dockerfile`:

### 4. Build the Docker image

```bash
docker build -t  assignment1-website .
```

Verify the image:

```bash
docker images
```

### 5. Run the container

```bash
docker run -d  --name assignment1-web -p 81:80   assignment1-website
```

Check its status:

```bash
docker ps
```
<img width="1093" height="116" alt="image" src="https://github.com/user-attachments/assets/f9ab8d34-cdeb-45aa-bf5b-c8b0ce3dd4b3" />

### 6. Test the website

Run:

```bash
curl -i http://localhost
```

Expected responses:

| Time in IST | Response body | HTTP status |
|---|---|---|
| 10 AM–12 PM | `Hello from Tanushi` | 200 |
| 4 PM–6 PM | `Hello from BuddyName` | 200 |
| Other times | `Website is unavailable at this time` | 503 |

The application checks the actual time, so the result depends on when you run `curl`.

<img width="1053" height="96" alt="image" src="https://github.com/user-attachments/assets/777debb9-44e6-4c6b-8b30-e6e60e9bff49" />


### 7. Configure the team domain

```bash
curl http://tanushi.ntd.com
```
<img width="716" height="99" alt="image" src="https://github.com/user-attachments/assets/f4997773-b9dc-4ac0-a7ae-e7c65aa73ce1" />

---


## Part 2: User-Specific Directory Permissions in Docker

### Objective

Create a container with this directory structure:

```text
Data/
└── Ninjas/
    ├── Mohan/
    ├── Uma/
    ├── Shikha/
    └── Mayank/
```

Requirements:

- Mohan can read and write in `Mohan/`.
- Mohan can read the other three directories.
- Mohan cannot write to the other three directories.

### 1. Create the project structure

```bash
mkdir -p ~/assignment1/part2
cd ~/assignment1/part2
```

Create a file named `Dockerfile`.

### 2. Write the Dockerfile

```dockerfile
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    passwd \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m Mohan && \
    useradd -m Uma && \
    useradd -m Shikha && \
    useradd -m Mayank

RUN mkdir -p /Data/Ninjas/{Mohan,Uma,Shikha,Mayank} && \
    chown root:root /Data /Data/Ninjas && \
    chmod 755 /Data /Data/Ninjas && \
    chown Mohan:Mohan /Data/Ninjas/Mohan && \
    chown Uma:Uma /Data/Ninjas/Uma && \
    chown Shikha:Shikha /Data/Ninjas/Shikha && \
    chown Mayank:Mayank /Data/Ninjas/Mayank && \
    chmod 755 /Data/Ninjas/{Mohan,Uma,Shikha,Mayank}

USER Mohan

CMD ["bash"]
```
<img width="568" height="98" alt="image" src="https://github.com/user-attachments/assets/fcbd3e0f-cdaa-4268-9100-91c7ffab540a" />


### 3. Build the image

```bash
docker build -t assignment1-part2:v1 .
```
<img width="1109" height="462" alt="image" src="https://github.com/user-attachments/assets/e68800ae-1840-4120-abc8-109e6535fa49" />


### 4. Run the Container

```
docker run --rm -it --name ninjas-container assignment1-part2:v1
```

<img width="1037" height="233" alt="image" src="https://github.com/user-attachments/assets/143eb584-f566-4eb5-9a1e-4e3cc3486fac" />

## Conclusion

This assignment helped me understand Docker image creation, container execution, Linux users and groups, directory permissions, and basic container security.
