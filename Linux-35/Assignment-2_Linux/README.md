# Asssignment-2_Linux

# 👥 UserManager.sh

A simple Bash utility to simulate Linux **User** and **Team (Group)** management with permission handling.

This utility allows you to create teams, add users, manage permissions, change user settings, and delete users or teams.

---

# 📌 Features

## 👨‍👩‍👧‍👦 Team Management

| Command | Description |
|---------|-------------|
| `addTeam` | Create a new team (group) |
| `delTeam` | Delete an existing team |
| `ls Team` | List all teams created |

---

## 👤 User Management

| Command | Description |
|---------|-------------|
| `addUser` | Add a user to a team |
| `delUser` | Delete a user |
| `changePasswd` | Change user password |
| `changeShell` | Change user login shell |
| `ls User` | List all users |

---

# 🔐 Permission Requirements

When a new user is created, the following permissions must be configured.

### 🏠 Home Directory Permissions

| User | Permission |
|------|------------|
| Owner | Read, Write, Execute (rwx) |
| Same Team Members | Read, Execute (r-x) |
| Others | Execute Only (--x) |

Example

```
drwxr-x--x
```

<img width="631" height="104" alt="WhatsApp Image 2026-08-06 at 7 02 11 PM" src="https://github.com/user-attachments/assets/2e889dd5-7e6b-4c70-be43-30af1399b3a7" />

---

# 📁 Shared Directories

Each user's home directory will automatically contain two directories.

```
/home
│
├── Rakesh
│   ├── team
│   └── ninja
│
└── Sandeep
    ├── team
    └── ninja
```
<img width="631" height="160" alt="WhatsApp Image 2026-08-06 at 7 52 36 PM" src="https://github.com/user-attachments/assets/175ea3fa-0741-41f1-9f73-858c771866f1" />

---

## 📂 team Directory

- Accessible only by members of the same team.
- Same team members have full permissions.

```
Owner : rwx
Team  : rwx
Others: ---
```

Example

```
drwxrwx---
```

---

## 🥷 ninja Directory

- Accessible by every Ninja user.
- All users have full permissions.

Example

```
drwxrwxrwx
```

---

# 🛠 Prerequisites

- Linux Operating System
- Bash Shell
- Root or sudo privileges
- Execute permission on the script

```bash
chmod +x UserManager.sh
```

---

# ▶️ Usage

```bash
./UserManager.sh <command> [arguments]
```

---

# 👨‍👩‍👧‍👦 Team Commands

## ➜ Create Team

```bash
./UserManager.sh addTeam amigo
```

Creates

```
amigo
```
<img width="435" height="35" alt="image" src="https://github.com/user-attachments/assets/75076d1a-1d01-48f3-9012-251f38741714" />

---

## ➜ Create Another Team

```bash
./UserManager.sh addTeam unixkings
```
<img width="486" height="38" alt="image" src="https://github.com/user-attachments/assets/29a6e46b-3cd7-464f-955c-75e6c3f4fc18" />

---

## ➜ Delete Team

```bash
./UserManager.sh delTeam amigo
```
<img width="424" height="36" alt="image" src="https://github.com/user-attachments/assets/2d6c65af-3058-4b95-8c72-d1a398bd6c8f" />

---

## ➜ List Teams

```bash
./UserManager.sh ls Team
```

Example Output

```
amigo
unixkings
```
<img width="631" height="457" alt="WhatsApp Image 2026-08-06 at 5 45 26 PM" src="https://github.com/user-attachments/assets/82386174-24fa-4489-baad-04befa7821d7" />

<img width="631" height="712" alt="WhatsApp Image 2026-08-06 at 5 45 26 PM (1)" src="https://github.com/user-attachments/assets/87befdb4-387c-447e-aa5b-7bd3f42ed620" />

---

# 👤 User Commands

## ➜ Add User

```bash
./UserManager.sh addUser Rakesh amigo
```
<img width="520" height="126" alt="image" src="https://github.com/user-attachments/assets/33f7911b-e686-4122-be30-d95f4ffa6dd2" />

Creates

```
/home/Rakesh
│
├── team
└── ninja
```
<img width="431" height="104" alt="image" src="https://github.com/user-attachments/assets/51950852-3386-4384-916c-284b3777950b" />

---

## ➜ Add Another User

```bash
./UserManager.sh addUser Sandeep unixkings
```
<img width="528" height="125" alt="image" src="https://github.com/user-attachments/assets/c898407a-a34e-4c92-bf90-608d04013db7" />

Creates

```
/home/Sandeep
│
├── team
└── ninja
```
<img width="362" height="83" alt="image" src="https://github.com/user-attachments/assets/2730317b-2013-4123-9318-49ca6566eb24" />

---

## ➜ Delete User

```bash
./UserManager.sh delUser Rakesh
```
<img width="631" height="107" alt="WhatsApp Image 2026-08-06 at 7 51 17 PM" src="https://github.com/user-attachments/assets/536d0bba-b28d-421a-8b40-e137d16359d8" />

---

## ➜ Change Password

```bash
./UserManager.sh changePasswd Rakesh
```

<img width="499" height="66" alt="image" src="https://github.com/user-attachments/assets/0cb21ce7-054c-43ef-ac99-006702f913bb" />


---

## ➜ Change Login Shell

```bash
./UserManager.sh changeShell Rakesh /bin/bash
```

Other examples

```bash
./UserManager.sh changeShell Rakesh /bin/sh

./UserManager.sh changeShell Rakesh /bin/zsh
```
<img width="529" height="100" alt="image" src="https://github.com/user-attachments/assets/ae3fb4d3-50f1-42d0-bbef-7674414314f5" />

---

## ➜ List Users

```bash
./UserManager.sh ls User
```

Example Output

```
Rakesh
Sandeep
```
<img width="631" height="658" alt="WhatsApp Image 2026-08-06 at 7 03 40 PM" src="https://github.com/user-attachments/assets/31124772-dd22-467d-b610-d22885f17811" />

---

# 📋 Example Workflow

```bash
./UserManager.sh addTeam amigo

./UserManager.sh addTeam unixkings

./UserManager.sh addUser Rakesh amigo

./UserManager.sh addUser Sandeep unixkings

./UserManager.sh ls User

./UserManager.sh ls Team

./UserManager.sh changePasswd Rakesh

./UserManager.sh changeShell Rakesh /bin/bash

./UserManager.sh delUser Rakesh

./UserManager.sh delTeam amigo
```

---

# 📂 Directory Structure

```
/home
│
├── Rakesh
│   ├── team
│   └── ninja
│
└── Sandeep
    ├── team
    └── ninja
```

---

# 🔒 Permission Summary

| Location | Owner | Team | Others |
|----------|-------|------|--------|
| Home Directory | rwx | r-x | --x |
| team Directory | rwx | rwx | --- |
| ninja Directory | rwx | rwx | --- |

<img width="631" height="104" alt="WhatsApp Image 2026-08-06 at 7 02 11 PM" src="https://github.com/user-attachments/assets/e37e9230-b1cb-41c3-a766-b615b26f6f3c" />

<img width="631" height="172" alt="WhatsApp Image 2026-08-06 at 7 07 05 PM" src="https://github.com/user-attachments/assets/86b85b37-be63-46c6-8b1d-b72fbcc41ac8" />

---

# 🧰 Linux Commands Used

✔ `groupadd`

✔ `groupdel`

✔ `useradd`

✔ `userdel`

✔ `passwd`

✔ `chsh`

✔ `mkdir`

✔ `chmod`

✔ `chown`

✔ `chgrp`

✔ `ls`

✔ `echo`

---

# ⚠️ Notes

- Run the script using **root** or **sudo** privileges.
- Team names should be unique.
- Usernames should be unique.
- Every new user automatically gets:
  - Home directory
  - `team` shared directory
  - `ninja` shared directory
- Proper ownership and permissions are applied automatically.
- Invalid commands or missing arguments will display a usage message.

---

# 💡 Example

```text
$ ./UserManager.sh addTeam amigo
✔ Team 'amigo' created successfully.

$ ./UserManager.sh addUser Rakesh amigo
✔ User 'Rakesh' added successfully.

$ ./UserManager.sh ls User
Rakesh

$ ./UserManager.sh ls Team
amigo

$ ./UserManager.sh changeShell Rakesh /bin/bash
✔ Login shell updated.

$ ./UserManager.sh delUser Rakesh
✔ User deleted successfully.
```

---

# 👩‍💻 Author

**Tanushi Rana**
