# Assignment-1_Ansible

---

## Requirements

The following teams/groups are required:

* `dev-team`
* `devops-team`
* `admin-group`

A total of **9 users** must be created:

* 3 users for `dev-team`
* 3 users for `devops-team`
* 3 users for `admin-group`

Each user must have a custom UID as specified in the assignment.

---

## Verify Ansible Connectivity

Before performing the assignment, verify that all managed nodes are reachable.

```bash
ansible server -i inventory -m ping
```

<img width="1102" height="237" alt="image" src="https://github.com/user-attachments/assets/3c6dba74-2c94-4612-9a2e-65fcd9805524" />


---
# A. Advanced User Management
## Create Teams/Groups


```bash
ansible server -i inventory -b -m group -a "name=dev-team state=present"
ansible server -i inventory -b -m group -a "name=devops-team state=present"
ansible server -i inventory -b -m group -a "name=admin-group state=present"
```

<img width="1363" height="613" alt="image" src="https://github.com/user-attachments/assets/f1474c3b-4556-4a99-9503-cb8db77172af" />


---

## Create Development Users

### Create Dev Users

```bash
ansible server -i inventory -b -m user -a "name=dev1 uid=2000 group=dev-team create_home=yes state=present"
ansible server -i inventory -b -m user -a "name=dev2 uid=2001 group=dev-team create_home=yes state=present"
ansible server -i inventory -b -m user -a "name=dev3 uid=2002 group=dev-team create_home=yes state=present"
```

<img width="1354" height="675" alt="image" src="https://github.com/user-attachments/assets/5e24b412-e21c-4d79-9323-3aa7ea42983c" />

<img width="1359" height="285" alt="image" src="https://github.com/user-attachments/assets/51cb4fe1-5818-47b9-9d95-65f791bf2316" />


### Create DevOps Users

Create three users in the `devops-team` group.

```bash
ansible server -i inventory -b -m user -a "name=devops1 uid=2003 group=devops-team create_home=yes state=present"
ansible server -i inventory -b -m user -a "name=devops2 uid=2004 group=devops-team create_home=yes state=present"
ansible server -i inventory -b -m user -a "name=devops3 uid=2005 group=devops-team create_home=yes state=present"
```

<img width="1359" height="583" alt="image" src="https://github.com/user-attachments/assets/0bfd6007-c158-4a05-8332-5fc1e89b290c" />

<img width="1358" height="286" alt="image" src="https://github.com/user-attachments/assets/5af90cb6-ed76-4121-8ce5-18d78d28b39f" />


### Create Admin Users

Create three users in the `admin-group`.

```bash
ansible server -i inventory -b -m user -a "name=admin1 uid=2006 group=admin-group create_home=yes state=present"
ansible server -i inventory -b -m user -a "name=admin2 uid=2007 group=admin-group create_home=yes state=present"
ansible server -i inventory -b -m user -a "name=admin3 uid=2008 group=admin-group create_home=yes state=present"
```
<img width="1358" height="532" alt="image" src="https://github.com/user-attachments/assets/26b79765-2c6b-4560-8aec-3b99d5c5b1f0" />

<img width="1359" height="270" alt="image" src="https://github.com/user-attachments/assets/ae0c882f-1861-436a-ad4d-5eec7634e46a" />

---

## Set different login shells

### Set Dev team shell

```
ansible server -i inventory -b -m user -a "name=dev1 uid=2000 group=dev-team shell=/bin/bash"
ansible server -i inventory -b -m user -a "name=dev2 uid=2001 group=dev-team shell=/bin/bash"
ansible server -i inventory -b -m user -a "name=dev3 uid=2002 group=dev-team shell=/bin/bash"
```

<img width="1361" height="670" alt="image" src="https://github.com/user-attachments/assets/29e1c8c5-ba93-4d06-a624-1cbdac8b5417" />


### Set DevOps team shell

```
ansible server -i inventory -b -m user -a "name=devops1 uid=2003 group=devops-team shell=/bin/zsh"
ansible server -i inventory -b -m user -a "name=devops2 uid=2004 group=devops-team shell=/bin/zsh"
ansible server -i inventory -b -m user -a "name=devops3 uid=2005 group=devops-team shell=/bin/zsh"
```
<img width="1359" height="680" alt="image" src="https://github.com/user-attachments/assets/55beb5c5-4cf5-4d38-8255-4e9b7b65a9ea" />

### Set Admin team shell

```
ansible server -i inventory -b -m user -a "name=admin1 uid=2006 group=admin-group shell=/bin/sh"
ansible server -i inventory -b -m user -a "name=admin2 uid=2007 group=admin-group shell=/bin/sh"
ansible server -i inventory -b -m user -a "name=admin3 uid=2008 group=admin-group shell=/bin/sh"
```

<img width="1358" height="684" alt="image" src="https://github.com/user-attachments/assets/d2d9cc23-e176-4018-a901-5b4a7ba22007" />

## Password Policies and Expiry

### Set password expiry for all users

```
ansible server -i inventory -b -m command -a "chage -M 30 dev1"
ansible server -i inventory -b -m command -a "chage -M 30 dev2"
ansible server -i inventory -b -m command -a "chage -M 30 dev3"
ansible server -i inventory -b -m command -a "chage -M 30 devops1"
ansible server -i inventory -b -m command -a "chage -M 30 devops2"
ansible server -i inventory -b -m command -a "chage -M 30 devops3"
ansible server -i inventory -b -m command -a "chage -M 30 admin1"
ansible server -i inventory -b -m command -a "chage -M 30 admin2"
ansible server -i inventory -b -m command -a "chage -M 30 admin3"
```

<img width="1360" height="562" alt="image" src="https://github.com/user-attachments/assets/4a0dc3b4-1ee2-47a4-812d-16d30233f2cb" />

## Sudo Access

### Grant sudo access to the DevOps team

```
ansible server -i inventory -b -m copy -a "content='%devops-team ALL=(ALL) ALL\n' dest=/etc/sudoers.d/devops-team mode=0440"
```

### Grant full sudo access to the Admin group

```
ansible server -i inventory -b -m copy -a "content='%admin-group ALL=(ALL) ALL\n' dest=/etc/sudoers.d/admin-group mode=0440"
```

<img width="1362" height="575" alt="image" src="https://github.com/user-attachments/assets/8de49264-3244-4c42-ba03-105e43da71b9" />

---

# B. Advanced Directory Structure

## Personal Namespaces

```
ansible server -i inventory -b -m command -a "ls -ld /home/dev1 /home/dev2 /home/dev3"
ansible server -i inventory -b -m command -a "ls -ld /home/devops1 /home/devops2 /home/devops3"
ansible server -i inventory -b -m command -a "ls -ld /home/admin1 /home/admin2 /home/admin3"
```
<img width="1359" height="310" alt="image" src="https://github.com/user-attachments/assets/1d80871e-dd5c-4112-ba08-8e13ad8cdb0b" />

## Team Directory Permissions

```
ansible server -i inventory -b -m file -a "path=/project-management/dev-team state=directory group=dev-team mode=2775"
ansible server -i inventory -b -m file -a "path=/project-management/devops-team state=directory group=devops-team mode=2775"
```
The 2 in 2775 enables the setgid bit, ensuring newly created files inherit the directory's group.

<img width="1356" height="496" alt="image" src="https://github.com/user-attachments/assets/6f82ada9-426a-4f74-8ca4-79b4ee9d82d4" />

## Project Directories

### WebApp

Assign Development team as the project team:
```
ansible server -i inventory -b -m file -a "path=/project-management/projects/WebApp owner=dev1 group=dev-team mode=2775"
```
Give DevOps read-only access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/WebApp entity=devops-team etype=group permissions=rx
state=present"
```
<img width="1363" height="654" alt="image" src="https://github.com/user-attachments/assets/8447991d-fa33-4fba-af05-02e5a0549bf0" />


### API

Assign DevOps team as the project team:
```
ansible server -i inventory -b -m file -a "path=/project-management/projects/API owner=devops1 group=devops-team mode=2775"
```
Give Development team read-execute access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/API entity=dev-team etype=group permissions=rx state=present"
```
<img width="1361" height="683" alt="image" src="https://github.com/user-attachments/assets/58204ef7-0aef-48a3-ae13-dc7eb00cbd6e" />


### Mobile

Assign Development team as the project team:
```
ansible server -i inventory -b -m file -a "path=/project-management/projects/Mobile owner=dev2 group=dev-team mode=2775"
```
Give DevOps team read-execute access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/Mobile entity=devops-team etype=group permissions=rx state=present"
```
<img width="1359" height="676" alt="image" src="https://github.com/user-attachments/assets/36634c36-8958-434f-bf29-6baedb4ac193" />


## Shared Resources

Give all teams read/write access to the shared directory:
```
ansible server -i inventory -b -m file -a "path=/project-management/shared owner=root group=dev-team mode=2775"
```

Add ACLs:
```
ansible server -i inventory -b -m acl -a "path=/project-management/shared entity=dev-team etype=group permissions=rwx state=present"
ansible server -i inventory -b -m acl -a "path=/project-management/shared entity=devops-team etype=group permissions=rwx state=present"
ansible server -i inventory -b -m acl -a "path=/project-management/shared entity=admin-group etype=group permissions=rwx state=present"
```
<img width="1351" height="509" alt="image" src="https://github.com/user-attachments/assets/4e18f6d3-8491-4ea8-8e10-1ccaa9f26dea" />

<img width="1360" height="600" alt="image" src="https://github.com/user-attachments/assets/2e08c030-ec52-4b79-8555-cd6d168c59d7" />

## Archive Directory

The archive directory contains completed projects and should be read-execute for users.
```
ansible server -i inventory -b -m file -a "path=/project-management/archive owner=root group=root mode=0755"
```
Give read and execute access to all teams:
```
ansible server -i inventory -b -m acl -a "path=/project-management/archive entity=dev-team etype=group permissions=rx state=present"
ansible server -i inventory -b -m acl -a "path=/project-management/archive entity=devops-team etype=group permissions=rx state=present"
ansible server -i inventory -b -m acl -a "path=/project-management/archive entity=admin-group etype=group permissions=rx state=present"
```
<img width="1362" height="514" alt="image" src="https://github.com/user-attachments/assets/ee4f726e-00c1-4472-8be7-a644cc2daeae" />

<img width="1359" height="588" alt="image" src="https://github.com/user-attachments/assets/1dd04816-edc0-494b-8b10-b052441ff502" />

---

# C. Security & Permission Matrix

## Personal Workspace: Owner full access, team read access

Owner full access, team read access.
```
ansible server -i inventory -b -m file -a "path=/home/dev1 owner=dev1 group=dev-team mode=0750"
```
Give the team read and execute access using ACL:
```
ansible server -i inventory -b -m acl -a "path=/home/dev1 entity=dev-team etype=group permissions=rx state=present"
```
<img width="1361" height="536" alt="image" src="https://github.com/user-attachments/assets/53d23951-e40d-4a12-81eb-6c09b4d2ec25" />


## Team Directories: Team full access, other teams read-only

### Development Team (full access)

```
ansible server -i inventory -b -m file -a "path=/project-management/dev-team state=directory owner=root group=dev-team mode=2775"
```

### DevOps team read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/dev-team entity=devops-team etype=group permissions=rx state=present"
```

### Admin full access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/dev-team entity=admin-group etype=group permissions=rwx state=present"
```
<img width="1361" height="631" alt="image" src="https://github.com/user-attachments/assets/656ba824-c3c9-4066-97e9-d585cfd18e01" />


## Project Directories: Project leads full access, assigned teams read/write, others read-only

### WebApp

Project Lead: dev1
Assigned Team: dev-team
```
ansible server -i inventory -b -m file -a "path=/project-management/projects/WebApp state=directory owner=dev1 group=dev-team mode=2775"
```

DevOps team read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/WebApp entity=devops-team etype=group permissions=rx state=present"
```

Admin full access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/WebApp entity=admin-group etype=group permissions=rwx state=present"
```

<img width="1359" height="620" alt="image" src="https://github.com/user-attachments/assets/bc19d3b7-d3a7-4c64-a7e9-a147b064bb59" />


### API

Project Lead: devops1
Assigned Team: devops-team
```
ansible server -i inventory -b -m file -a "path=/project-management/projects/API state=directory owner=devops1 group=devops-team mode=2775"
```

Development team read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/API entity=dev-team etype=group permissions=rx state=present"
```

Admin full access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/API entity=admin-group etype=group permissions=rwx state=present"
```

<img width="1360" height="632" alt="image" src="https://github.com/user-attachments/assets/10f33617-0c25-4a25-8f42-0a205318847c" />


### Mobile

Project Lead: dev2
Assigned Team: dev-team
```
ansible server -i inventory -b -m file -a "path=/project-management/projects/Mobile state=directory owner=dev2 group=dev-team mode=2775"
```
DevOps team read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/Mobile entity=devops-team etype=group permissions=rx state=present"
```
Admin full access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/projects/Mobile entity=admin-group etype=group permissions=rwx state=present"
```
<img width="1364" height="641" alt="image" src="https://github.com/user-attachments/assets/d1a16595-1e1e-48e5-b0bf-23b544ce2992" />


## Shared Resources: All teams read/write access

All teams have read/write access.

Create the directory:
```
ansible server -i inventory -b -m file -a "path=/project-management/shared state=directory owner=root group=dev-team mode=2775"
```
Development team:
```
ansible server -i inventory -b -m acl -a "path=/project-management/shared entity=dev-team etype=group permissions=rwx state=present"
```
<img width="1362" height="454" alt="image" src="https://github.com/user-attachments/assets/6a751fb7-ec1e-4ac5-99d9-75f142dc59f5" />

DevOps team:
```
ansible server -i inventory -b -m acl -a "path=/project-management/shared entity=devops-team etype=group permissions=rwx state=present"
```
Admin group:
```
ansible server -i inventory -b -m acl -a "path=/project-management/shared entity=admin-group etype=group permissions=rwx state=present"
```
<img width="1359" height="467" alt="image" src="https://github.com/user-attachments/assets/f5065d9f-7971-4b9b-a33c-ecb76754b246" />


## Archive: All users access

Create the directory:
```
ansible server -i inventory -b -m file -a "path=/project-management/archive state=directory owner=root group=root mode=0755"
```
Development team read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/archive entity=dev-team etype=group permissions=rx state=present"
```
<img width="1363" height="434" alt="image" src="https://github.com/user-attachments/assets/ea4acd9b-4bb8-4c0a-8b9c-c3521d007f9b" />

DevOps team read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/archive entity=devops-team etype=group permissions=rx state=present"
```
Admin group read-execute:
```
ansible server -i inventory -b -m acl -a "path=/project-management/archive entity=admin-group etype=group permissions=rx state=present"
```
<img width="1363" height="478" alt="image" src="https://github.com/user-attachments/assets/122d2365-3aed-4267-b102-c046aa97f251" />


## Admin Area: Only admin-group full access

Only admin-group has full access.

Create the directory:
```
ansible server -i inventory -b -m file -a "path=/project-management/admin-area state=directory owner=root group=admin-group mode=2770"
```
Admin group full access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/admin-area entity=admin-group etype=group permissions=rwx state=present"
```
<img width="1361" height="414" alt="image" src="https://github.com/user-attachments/assets/07fb1465-0bfc-4d4f-aeb7-cc00e6414ea8" />


Remove Dev team access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/admin-area entity=dev-team etype=group state=absent"
```
Remove DevOps team access:
```
ansible server -i inventory -b -m acl -a "path=/project-management/admin-area entity=devops-team etype=group state=absent"
```
<img width="1363" height="429" alt="image" src="https://github.com/user-attachments/assets/5fe64b61-4492-42c5-a2f8-73d99cc4fd32" />
