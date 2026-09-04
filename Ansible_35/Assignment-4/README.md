# Asssignment-4_Ansible

Inventory File
```
[app]
server1 ansible_host=52.64.228.182 ansible_ssh_private_key_file="/home/tanushi/key-ec2.pem" ansible_user=ubuntu ansible_host_key_checking=false
```

## Create role and connectivity 

```
ansible-galaxy init system-manager
```

```
ansible app -i inventory -m ping
```

```
ansible-playbook -i inventory assignment-4.yml --syntax-check
```

<img width="1001" height="96" alt="image" src="https://github.com/user-attachments/assets/e3e77cd4-31a6-421d-afeb-40b39dfb1b16" />


This is `assignment-4.yml`:

<img width="595" height="201" alt="image" src="https://github.com/user-attachments/assets/98f4c158-2751-46a3-a9fb-4e1052b9cad8" style="border: 2px solid black;" />

## Steps 

The `system-manager` role provides the following features:

### 1. Software Management

Install required software packages such as:

- Git
- OpenJDK
- Maven

```
TASK [system-manager : Manage software packages]
TASK [system-manager : Update apt cache]
TASK [system-manager : Install required software]
TASK [system-manager : Display package install]
```

<img width="1035" height="576" alt="image" src="https://github.com/user-attachments/assets/f96cbd02-69bb-47f9-820a-b1ff6be23015" style="border: 2px solid black;"/>


### 2. User Management

Create and manage Linux users with:

- Username
- UID
- Shell
- Groups
- Home directory

```
TASK [system-manager : Manage users and groups]
TASK [system-manager : Create required users]
```

### 3. Group Management

Create required Linux groups.

```
TASK [system-manager : Manage users and groups]
TASK [system-manager : Create required groups]
```

<img width="1053" height="299" alt="image" src="https://github.com/user-attachments/assets/ed23e97e-1584-4dc5-b0f0-af0ae1e741c8" />


### 4. Git Repository Management

Clone Git repositories to specific locations on the server.

```
TASK [system-manager : Manage Git repositories]
TASK [system-manager : Install Git]
TASK [system-manager : Manage Git repositories]
```

<img width="1279" height="218" alt="image" src="https://github.com/user-attachments/assets/9ba88f52-b4bc-42e9-b4dd-e05a7bb4e11c" />


### 5. Directory Management

Create required directory structures with:

- Owner
- Group
- Permissions

```
TASK [system-manager : Manage directory structure]
TASK [system-manager : Create required directories]
```

<img width="1246" height="320" alt="image" src="https://github.com/user-attachments/assets/632f93de-11f5-4dd7-9547-014cd6c27b50" />

---

# Role Structure

```text
system-manager/
│
├── README.md
│
├── defaults/
│   └── main.yml
│
├── files/
│
├── handlers/
│   └── main.yml
│
├── meta/
│   └── main.yml
│
├── tasks/
│   ├── main.yml
│   ├── packages.yml
│   ├── users.yml
│   ├── git.yml
│   └── directories.yml
│
├── templates/
│
├── tests/
│   ├── inventory
│   └── test.yml
│
└── vars/
    └── main.yml
