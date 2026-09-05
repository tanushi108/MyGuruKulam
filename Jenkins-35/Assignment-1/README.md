# Jenkins Assignment 1

## Overview

This assignment demonstrates Jenkins automation for **Git branch operations, parameterized builds, artifact publishing, job chaining, and build notifications**.

The assignment is divided into two parts:

* **Part 1:** Perform Git branch operations through a Jenkins job.
* **Part 2:** Create and publish a file using two Jenkins jobs with automatic job triggering.

---

# Part 1 — Jenkins Job for Git Branch Operations

## Objective

Create a Jenkins job that can perform the following Git operations:

1. Create a branch
2. List all branches
3. Merge one branch with another branch
4. Rebase one branch with another branch
5. Delete a branch

If any operation fails, Jenkins should send:

* Slack notification
* Email notification



## Git Operations

### 1. Create a Branch

The Jenkins job allows a new Git branch to be created.

Example:

```bash
git checkout -b feature-branch
```

The branch can then be pushed to the remote repository if required:

```bash
git push origin feature-branch
```

<img width="1365" height="594" alt="image" src="https://github.com/user-attachments/assets/2ada8323-6fec-44c4-9264-69a14c6280a0" />

<img width="1026" height="384" alt="image" src="https://github.com/user-attachments/assets/ad052d2b-5ee6-48c6-82b9-e507b1262e68" />

<img width="1199" height="403" alt="image" src="https://github.com/user-attachments/assets/b1fd796d-5112-4751-864a-cdb0c1491fef" />


---

### 2. List All Branches

The job can display all local and remote branches:

```bash
git branch -a
```
<img width="1004" height="459" alt="image" src="https://github.com/user-attachments/assets/3e4ac796-0616-4b04-8e65-02efe675b9d5" />

<img width="1064" height="489" alt="image" src="https://github.com/user-attachments/assets/dd266e6d-4eed-4461-9b82-953dbe919fe6" />


---

### 3. Merge One Branch With Another

To merge one branch into another:

```bash
git checkout feature-branch
git merge main
```
<img width="1032" height="439" alt="image" src="https://github.com/user-attachments/assets/dd697eee-d1d2-4414-b871-4f1fbba45054" />

<img width="968" height="463" alt="image" src="https://github.com/user-attachments/assets/d07cdebb-bc83-4963-a64a-d58b70a8bf7c" />

<img width="661" height="529" alt="image" src="https://github.com/user-attachments/assets/63681450-8118-467d-ad22-8e4be1752db0" />

---

### 4. Rebase One Branch With Another

To rebase a branch:

```bash
git checkout dev
git rebase main
```
<img width="936" height="368" alt="image" src="https://github.com/user-attachments/assets/ff6d7cba-894f-420c-9063-75b12a13026a" />

<img width="916" height="499" alt="image" src="https://github.com/user-attachments/assets/cebdd6e8-7b74-445c-a4ad-943eca25777b" />

<img width="816" height="429" alt="image" src="https://github.com/user-attachments/assets/9ca623b4-714d-44e9-aa61-c8cfba330150" />

---

### 5. Delete a Branch

To delete a local branch:

```bash
git branch -d feature-branch
```

To delete a remote branch:

```bash
git push origin --delete feature-branch
```

<img width="916" height="453" alt="image" src="https://github.com/user-attachments/assets/8cfd9e02-a96a-4fa9-aa8c-5910eed7f579" />

<img width="1083" height="410" alt="image" src="https://github.com/user-attachments/assets/86039542-bbb1-45e3-b1b4-b7aa7c01cc14" />

<img width="1042" height="355" alt="image" src="https://github.com/user-attachments/assets/4a347c01-57fd-4804-a318-a1038dfa9f3f" />

---

## Failure Notifications

The Jenkins job is configured to send notifications when any stage or operation fails.

### Slack Notification

A Slack notification is sent when the build fails.

<img width="937" height="428" alt="image" src="https://github.com/user-attachments/assets/57373487-1bbb-45db-b3ae-f99fd071650e" />



<img width="892" height="542" alt="image" src="https://github.com/user-attachments/assets/c8e80e4b-49c9-4830-9122-6d8b736a11e4" />

<img width="1365" height="573" alt="image" src="https://github.com/user-attachments/assets/ba01a6af-513c-401c-8f32-57da1a932815" />


### Email Notification

An email notification is also sent when the build fails.

The email contains information such as:

* Job name
* Build number
* Build status
* Build ID
* Build URL
* Failure information

<img width="975" height="431" alt="image" src="https://github.com/user-attachments/assets/dedcd263-9eec-4088-9f7e-b64296712d3b" />

<img width="928" height="448" alt="image" src="https://github.com/user-attachments/assets/89a86252-1f45-466c-8112-5050e2eab984" />

<img width="873" height="529" alt="image" src="https://github.com/user-attachments/assets/41c4759f-ecd8-4995-a4e7-50b75a65d44f"  />

<img width="830" height="493" alt="image" src="https://github.com/user-attachments/assets/77010e24-1564-4b43-abca-8ee84cbf1b35" />

---

# Part 2 — Parameterized Jenkins Jobs

## Objective

Part 2 consists of two Jenkins jobs:

```text
Job 1
  |
  | Successful completion
  v
Job 2
  |
  v
Publish File
```

The first job accepts a **Ninja Name** as a parameter, creates a file, and writes the required content.

The second job is automatically triggered after the first job completes successfully and publishes the file using a web server.

---

# Job 1 — Create File

## Job Name

Example:

```text
Assignment-1-Part-B-Create
```

## Parameter

The job accepts a String Parameter:

```text
Ninja Name
```

Example input:

```text
Tanushi
```

<img width="1109" height="503" alt="image" src="https://github.com/user-attachments/assets/bfcf7f0a-6a38-4fc2-9bcc-f84996bd4d73" />


## File Creation

The job creates a file, for example:

```text
ninja.txt
```

The following content is written into the file:

```text
Tanushi from DevOps Ninja
```

Example shell command:

```bash
echo "$Ninja_Name from DevOps Ninja" > ninja.txt
```

---

## Publish the File as an Artifact

The generated file is archived by Jenkins so that it can be used by the downstream job.

Example artifact:

```text
ninja.txt
```


<img width="1016" height="501" alt="image" src="https://github.com/user-attachments/assets/814476d2-2fcb-488b-b971-e73f954f504f" />


<img width="791" height="274" alt="image" src="https://github.com/user-attachments/assets/16fd6eab-c285-4e7f-b5c2-50f361569f8c" />

<img width="1126" height="506" alt="image" src="https://github.com/user-attachments/assets/2696e7fe-30f1-4f0e-af05-4cdf0cdeaafc" />

---

# Job 2 — Publish File

## Job Name

Example:

```text
Assignment-1-Part-B-Publish
```

Job 2 is responsible for publishing the file created by Job 1.

The file is copied from the upstream job and placed inside the web server's document root.

Example:

```text
/var/www/html/
```

The file can then be accessed through a browser.

Example:

```text
http://localhost/ninja.txt
```

If the input was:

```text
Tanushi
```

The browser displays:

```text
Tanushi from DevOps Ninja
```

---

# Job Chaining

Job 2 must **automatically trigger only when Job 1 succeeds**.

The configuration is:

```text
Ninja-File-Creation
        |
        | SUCCESS
        v
Ninja-File-Publish
```

<img width="501" height="354" alt="image" src="https://github.com/user-attachments/assets/ef3eb295-3e64-4fee-a31e-9bca8079c25e" />

Job 2 should not run if Job 1 fails.

This can be configured using Jenkins:

```text
Job 1
 → Post-build Actions
 → Build other projects
 → Ninja-File-Publish
 → Trigger only if build is stable/successful
```

Alternatively, Job 2 can be configured with an upstream trigger depending on the Jenkins job type.

<img width="773" height="529" alt="image" src="https://github.com/user-attachments/assets/c5fa604a-3fa8-4cb6-af21-7fca8196c9df" />

<img width="841" height="215" alt="image" src="https://github.com/user-attachments/assets/6bde9162-87f0-45cd-91fc-cdb303a1a6c3" />

---

# Notifications

Both jobs are configured to send Slack and Email notifications.

## Failure

If any step fails:

```text
Jenkins
   |
   +---- Slack Notification
   |
   +---- Email Notification
```

The notification contains:

```text
Job Name
Build Number
Build Status
Build URL
```

<img width="751" height="236" alt="image" src="https://github.com/user-attachments/assets/195c7640-ee64-4fe1-865c-5004c3e83182" />

<img width="1362" height="524" alt="image" src="https://github.com/user-attachments/assets/f0fb50aa-e55b-4ccc-b8b9-77baddc6c686" />

---






# Conclusion

This assignment demonstrates how Jenkins can be used to automate **Git operations, parameterized builds, artifact management, upstream/downstream job triggering, web-server publishing, and build notifications**.

The complete implementation provides an automated CI workflow where Jenkins handles the operations and notifies the team about both successful and failed builds.
