# Assignment-8_Linux

<p align="center">
  <img src="https://img.shields.io/badge/Git-Branch%20Management-orange?style=for-the-badge&logo=git" alt="Git">
  <img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnubash" alt="Bash">
  <img src="https://img.shields.io/badge/GitHub-Repository-black?style=for-the-badge&logo=github" alt="GitHub">
</p>

---

## 📌 Objective

The objective of this assignment is to understand and implement important **Git and GitHub concepts** using practical commands and Bash scripting.

### 🎯 Topics Covered

* 🌿 Git Branch Management
* 🔀 Fast-Forward & Non-Fast-Forward Merge
* ⚔️ Merge Conflict Resolution
* 🧩 Ours & Theirs Concept
* 🔄 Git Rebase
* 🏷️ Git Tags
* 📊 Git Commit Reports
* 🐚 Bash Scripting
* 🤖 Git Command Automation

---

# 📂 Project Structure

```text
📦 Assignment-8_Linux
 ├── 📁 ninja
 │    └── 📄 README.md
 │
 ├── 📜 gitBranches.sh
 ├── 📜 gitTags.sh
 ├── 📜 gitCommitReport.sh
 └── 📘 README.md
```

<img width="578" height="244" alt="image" src="https://github.com/user-attachments/assets/13ece740-2246-4f1e-bbfc-9802cc733059" />

---

# 🌿 PART A — Git Branching & Merge

## 1️⃣ Create Ninja Folder

A `ninja` directory is created at the root level of the repository.

```bash
mkdir ninja
echo "Trying fast forward merge" > ninja/README.md
```

The file contains:

```text
Trying fast forward merge
```
<img width="992" height="341" alt="image" src="https://github.com/user-attachments/assets/34310c3c-df7a-4edd-8663-672fbbd2a6d2" />

---

## 2️⃣ Create Ninja Branch

Create and switch to the `ninja` branch:

```bash
git checkout -b ninja
```

Check the current status:

```bash
git status
```

<img width="761" height="196" alt="image" src="https://github.com/user-attachments/assets/a88a842c-6515-4f95-9f19-8845f4f1fab9" />


---

## 3️⃣ Commit Changes

Add and commit the README file:

```bash
git add ninja/README.md
git commit -m "Add ninja README"
```
<img width="726" height="119" alt="image" src="https://github.com/user-attachments/assets/5c03bb54-b218-40ff-965b-8907ad2b82fd" />

---

## 4️⃣ Merge Ninja into Main

Switch to the main branch:

```bash
git checkout main
```

```bash
git merge ninja -m "Merge ninja branch"
```
<img width="800" height="195" alt="image" src="https://github.com/user-attachments/assets/96eee7ea-1acc-42dc-b270-951d32976c82" />


---

# ⚔️ 5️⃣ Generate Merge Conflict

After the first merge, modify `README.md` differently on both branches.

### 🟦 Main Branch

```bash
git checkout main

echo "Changes in master branch" > ninja/README.md

git add ninja/README.md
git commit -m "Update README in master"
```
<img width="830" height="193" alt="image" src="https://github.com/user-attachments/assets/f2201915-91f4-4737-be1d-dd50b3809dd1" />


### 🟩 Ninja Branch

```bash
git checkout ninja

echo "Changes in ninja branch" > ninja/README.md

git add ninja/README.md
git commit -m "Update README in ninja"
```
<img width="936" height="157" alt="image" src="https://github.com/user-attachments/assets/00912242-6eee-44a0-92a7-42d65030cc91" />


Both branches have now modified the same file differently.

---

## 💥 6️⃣ Merge Conflict

Switch to main:

```bash
git checkout main
```

Merge ninja:

```bash
git merge ninja
```

Git generates a conflict because both branches modified the same file.

Check the conflict:

```bash
git status
```
<img width="923" height="450" alt="image" src="https://github.com/user-attachments/assets/4b82ab2d-231f-4841-bda5-f65d88896f3d" />



---

# 🧩 7️⃣ Resolve Conflict Using `THEIRS`

In Git:

| Concept     | Meaning             |
| ----------- | ------------------- |
| 🟦 `ours`   | Current branch      |
| 🟩 `theirs` | Branch being merged |

Here:

```text
Current branch = main
Merged branch  = ninja
```

The assignment requires the **ninja changes to override the main changes**.

Therefore, use:

```bash
git checkout --theirs ninja/README.md
```

Then stage and commit:

```bash
git add ninja/README.md
git commit -m "Resolve merge conflict using ninja changes"
```

Verify:

```bash
cat ninja/README.md
```

Expected output:

```text
Changes in ninja branch
```
<img width="943" height="154" alt="image" src="https://github.com/user-attachments/assets/25e9d786-734c-48b9-854d-5ed45399f617" />


### 🧠 Ours vs Theirs

```mermaid
flowchart LR
    A["🟦 MAIN<br/>Changes in master branch"]
    B["🟩 NINJA<br/>Changes in ninja branch"]
    C{"⚔️ Merge Conflict"}
    D["git checkout --theirs"]
    E["✅ Ninja Changes Accepted"]

    A --> C
    B --> C
    C --> D
    D --> E
```

---

# 🔄 Good To Do — Rebase

Rebase is used to replay commits from one branch on top of another branch.

```bash
git checkout ninja
git rebase main
```
<img width="765" height="343" alt="image" src="https://github.com/user-attachments/assets/aa2aba97-a379-44c4-bc76-ce4eba25dbf2" />

The ninja commits are replayed on top of the latest main branch.

### ⚠️ Rebase Conflict

If a conflict occurs:

```bash
git status
```

Resolve the conflict and run:

```bash
git add ninja/README.md
git rebase --continue
```

To cancel the rebase:

```bash
git rebase --abort
```

---

# 🛠️ PART B — Git Branch Management Script

## 📜 `gitBranches.sh`

The `gitBranches.sh` script automates common branch operations.

### ✨ Features

* 📋 List branches
* ➕ Create branch
* 🗑️ Delete branch
* 🔀 Merge branches
* 🔄 Rebase branches

---

## 📋 List Branches

```bash
./gitBranches.sh -l
```

Example:

```text
main
ninja
```
<img width="642" height="123" alt="image" src="https://github.com/user-attachments/assets/b28cdc83-e570-4e50-848b-929c44656450" />

---

## ➕ Create Branch

```bash
./gitBranches.sh -b feature1
```
<img width="671" height="161" alt="image" src="https://github.com/user-attachments/assets/b34abe14-cbd7-42b3-80ac-2f0c6d6a633a" />

---

## 🗑️ Delete Branch

```bash
./gitBranches.sh -d feature1
```
<img width="667" height="141" alt="image" src="https://github.com/user-attachments/assets/a0922acb-91dc-45b3-8279-80d084878a53" />

---

## 🔀 Merge Two Branches

```bash
./gitBranches.sh -m -1 ninja -2 main
```

This means:

```text
ninja → main
```
<img width="727" height="162" alt="image" src="https://github.com/user-attachments/assets/ecd80d62-73a0-4144-a3a3-407f8a4203de" />

The `ninja` branch is merged into the `main` branch.

---

## 🔄 Rebase Two Branches

```bash
./gitBranches.sh -r -1 ninja -2 main
```

This means:

```text
ninja → rebase on main
```
<img width="727" height="120" alt="image" src="https://github.com/user-attachments/assets/d08780ee-a7c0-4329-9fdf-655f0016f561" />


### 📊 Branch Script Flow

```mermaid
flowchart TD
    A["📜 gitBranches.sh"] --> B["📋 List"]
    A --> C["➕ Create"]
    A --> D["🗑️ Delete"]
    A --> E["🔀 Merge"]
    A --> F["🔄 Rebase"]
```

---

# 🏷️ PART C — Git Tag Management

## 📜 `gitTags.sh`

The `gitTags.sh` script manages Git tags.

### ✨ Features

* 🏷️ Create tag
* 📋 List tags
* 🗑️ Delete tag

---

## 🏷️ Create Tag

```bash
./gitTags.sh -t ninja_1.0
```

```bash
./gitTags.sh -t ninja_1.1
```
<img width="660" height="117" alt="image" src="https://github.com/user-attachments/assets/f19b173d-e1af-49d9-b7e2-7f153b400916" />


---

## 📋 List Tags

```bash
./gitTags.sh -l
```

Output:

```text
ninja_1.0
ninja_1.1
```
<img width="569" height="91" alt="image" src="https://github.com/user-attachments/assets/7335336e-9087-4a60-af1d-07bfb415a80d" />

---

## 🗑️ Delete Tag

```bash
./gitTags.sh -d ninja_1.0
```

<img width="635" height="112" alt="image" src="https://github.com/user-attachments/assets/f200c0e9-0422-406e-97af-e696a07581d6" />

---

# 📊 PART D — Git Commit Report

## 📜 `gitCommitReport.sh`

The `gitCommitReport.sh` script generates a report containing information about commits made within a specified number of days.

### 📥 Input

The script accepts:

* 🌐 Repository URL
* 📅 Number of days

### 📤 Output

The report contains:

| Field             | Description                    |
| ----------------- | ------------------------------ |
| 📅 Commit Date    | Date and time when the commit was created      |
| 👤 Author Name    | Name of commit author          |
| 📧 Author Email   | Author email address           |
| 💬 Commit Message | Commit description             |

---

## ▶️ Usage

```bash
./gitCommitReport.sh -u https://github.com/tanushi108/Assignment-1.1_Linux.git -d 40
```
<img width="1343" height="259" alt="image" src="https://github.com/user-attachments/assets/70a407b4-2e8b-47c7-8dd7-c825c4706406" />

---

# 🔎 Commit Report Flow

```mermaid
flowchart TD
    A["🌐 Repository URL"] --> B["📥 Clone Repository"]
    B --> C["📅 Calculate Date Range"]
    C --> D["🔍 Git Log"]
    D --> E["📅 Commit Date"]
    D --> F["👤 Author Name"]
    D --> G["📧 Author Email"]
    D --> H["💬 Commit Message"]
    E --> I["📄 Generate Commit Report"]
    F --> I
    G --> I
    H --> I
```

---

# 🧪 Testing

Before submitting the assignment, verify the scripts.

### Branch Script

```bash
./gitBranches.sh -l
./gitBranches.sh -b testbranch
./gitBranches.sh -l
./gitBranches.sh -d testbranch
```

### Tag Script

```bash
./gitTags.sh -t test_1.0
./gitTags.sh -l
./gitTags.sh -d test_1.0
```

### Commit Report

```bash
./gitCommitReport.sh -u <repository-url> -d 10
```

---

# 📁 Final Repository Structure

```text
📦 Assignment-8_Linux
 ├── 📁 ninja
 │    └── 📄 README.md
 │
 ├── 📜 gitBranches.sh
 ├── 📜 gitTags.sh
 ├── 📜 gitCommitReport.sh
 └── 📘 README.md
```

---

# 🧠 Git Concepts Learned

| Concept        | Purpose                                              |
| -------------- | ---------------------------------------------------- |
| 🌿 Branch      | Work independently without affecting another branch  |
| 🔀 Merge       | Combine changes from different branches              |
| ⚔️ Conflict    | Occurs when Git cannot automatically combine changes |
| 🟦 Ours        | Keep changes from the current branch                 |
| 🟩 Theirs      | Keep changes from the branch being merged            |
| 🔄 Rebase      | Replay commits on top of another branch              |
| 🏷️ Tag        | Mark a specific commit/version                       |
| 📊 Git Log     | View commit history                                  |
| 🐚 Bash Script | Automate Git operations                              |

---
---

## 👩‍💻 Author

**Tanushi Rana**

⭐ *Git • GitHub • Linux • Bash Scripting*
