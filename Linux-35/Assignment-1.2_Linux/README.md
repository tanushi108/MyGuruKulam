# Assignment-1.2_Linux

# 📁 FileManager.sh

A simple Bash utility to perform **Directory Management** and **File Management** operations using basic Linux commands.

> **Note:** This project does **NOT** use the `sed` command. Only basic Linux commands are used.

---

# 📌 Features

## 📂 Directory Operations

| Command | Description |
|---------|-------------|
| `addDir` | Create a directory |
| `deleteDir` | Delete a directory |
| `listFiles` | List only files |
| `listDirs` | List only directories |
| `listAll` | List files and directories |


## 📄 File Operations

| Command | Description |
|---------|-------------|
| `addFile` | Create a file (optionally with initial content) |
| `addContentToFile` | Append content to a file |
| `addContentToFileBegining` | Add content at the beginning of a file |
| `showFileBeginingContent` | Display first N lines |
| `showFileEndContent` | Display last N lines |
| `showFileContentAtLine` | Display a specific line |
| `showFileContentForLineRange` | Display a range of lines |
| `moveFile` | Move or rename a file |
| `copyFile` | Copy a file |
| `clearFileContent` | Remove all file contents |
| `deleteFile` | Delete a file |


# 🛠 Prerequisites

- Linux Operating System
- Bash Shell
- Execute permission on the script
```bash
chmod +x FileManager.sh
```

<img width="492" height="327" alt="image" src="https://github.com/user-attachments/assets/d10b7dcb-fbae-4ba6-92b2-944c14fd165b" />

# ▶️ Usage

./FileManager.sh <command> [arguments]

# 📂 Directory Commands

## ➜ Create Directory
```bash
./FileManager.sh addDir /tmp dir1
./FileManager.sh addDir /tmp dir2
./FileManager.sh addDir /tmp dir3
```
Creates

/tmp

└── dir1

└──dir2

└──dir3

<img width="629" height="202" alt="image" src="https://github.com/user-attachments/assets/1467309d-f4fa-498c-849d-6b43072fa28a" />


## ➜ Delete Directory

```bash
./FileManager.sh deleteDir /tmp dir3
```
Deletes

/tmp/dir3

<img width="476" height="77" alt="image" src="https://github.com/user-attachments/assets/fcf14863-95a5-422d-ae8c-09163f3d3200" />

## ➜ List Only Files

```bash
./FileManager.sh listFiles /tmp
```
<img width="417" height="90" alt="image" src="https://github.com/user-attachments/assets/53060980-8e37-49c3-995f-d2c03e35f965" />

## ➜ List Only Directories

```bash
./FileManager.sh listDirs /tmp
```

Example Output

dir1

dir2

dir3

<img width="712" height="372" alt="image" src="https://github.com/user-attachments/assets/8562ae02-9e67-46a4-8351-9288be4d426d" />


## ➜ List All

```bash
./FileManager.sh listAll /tmp
```

Example Output

dir1

dir2

dir3

<img width="989" height="372" alt="image" src="https://github.com/user-attachments/assets/12f1ce81-709a-4ba9-b856-36eb91bf04b0" />


# 📄 File Commands

## ➜ Create Empty File

```bash
./FileManager.sh addFile /tmp/dir1 file1.txt
```
<img width="507" height="41" alt="image" src="https://github.com/user-attachments/assets/523a9576-c05b-4399-9855-7a72539f5f45" />


## ➜ Create File with Initial Content

```bash
./FileManager.sh addFile /tmp/dir1 file1.txt "Initial Content"
```

Content

Initial Content

<img width="666" height="38" alt="image" src="https://github.com/user-attachments/assets/a3aa7429-9b93-459e-b7a7-3c52b4d27bc0" />


## ➜ Append Content

```bash
./FileManager.sh addContentToFile /tmp/dir1 file1.txt "Additional Content"
```

Content
Initial Content
Additional Content

<img width="731" height="36" alt="image" src="https://github.com/user-attachments/assets/c07f1a99-57fc-46bb-8646-c3193e2a4a8e" />

<img width="812" height="264" alt="image" src="https://github.com/user-attachments/assets/abfa0916-cc0d-4aed-97eb-01ebe430c6f9" />

## ➜ Add Content at Beginning

```bash
./FileManager.sh addContentToFileBegining /tmp/dir1 file1.txt "New First Line"
```
Content
New First Line
Initial Content
Additional Content

<img width="804" height="40" alt="image" src="https://github.com/user-attachments/assets/b8777e56-7d65-4e5a-af93-9d3c0c5e0298" />

## ➜ Show First N Lines

```bash
./FileManager.sh showFileBeginingContent /tmp/dir1 file1.txt 5
```
<img width="639" height="101" alt="image" src="https://github.com/user-attachments/assets/4cb7c3cc-6349-4567-8f4e-1bfcaf9d9fa8" />

## ➜ Show Specific Line

```bash
./FileManager.sh showFileContentAtLine /tmp/dir1 file1.txt 10
```
<img width="620" height="38" alt="image" src="https://github.com/user-attachments/assets/1cc378e7-350a-469b-8a2f-61a0bd2bae4e" />


## ➜ Show Line Range

```bash
./FileManager.sh showFileContentForLineRange /tmp/dir1 file1.txt 5 10
```

<img width="670" height="116" alt="image" src="https://github.com/user-attachments/assets/41b70934-f1d1-405d-a56b-656aeea447ef" />


## ➜ Rename File

```bash
./FileManager.sh moveFile /tmp/dir1/file1.txt /tmp/dir1/file2.txt
./FileManager.sh moveFile /tmp/dir1/file2.txt /tmp/dir2/
./FileManager.sh listAll /tmp/dir1
./FileManager.sh listAll /tmp/dir2
```
<img width="812" height="250" alt="image" src="https://github.com/user-attachments/assets/52761db2-3c3e-4987-acd3-e6c04f960e6e" />


## ➜ Move File

```bash
./FileManager.sh moveFile /tmp/dir1/file1.txt /tmp/dir1/file2.txt
./FileManager.sh moveFile /tmp/dir1/file2.txt /tmp/dir2/
```
<img width="645" height="70" alt="image" src="https://github.com/user-attachments/assets/3fb7e11d-08a1-4f58-9560-77ea2861af39" />

<img width="496" height="155" alt="image" src="https://github.com/user-attachments/assets/63c4bf7c-ad1a-4e98-b580-e7a34e876936" />

## ➜ Copy File

```bash
./FileManager.sh copyFile /tmp/dir2/file2.txt /tmp/dir1/
./FileManager.sh copyFile /tmp/dir1/file2.txt /tmp/dir1/file3.txt
ls /tmp/dir1
cat /tmp/dir1/file3.txt
```
<img width="812" height="319" alt="image" src="https://github.com/user-attachments/assets/de854167-f915-4f54-b9a3-4c55da8da2ce" />


## ➜ Clear File Content

```bash
./FileManager.sh clearFileContent /tmp/dir1 file3.txt
```

After execution

```
(empty file)
```
<img width="578" height="50" alt="image" src="https://github.com/user-attachments/assets/180cf09e-b269-4455-9909-8fee6de50777" />

## ➜ Delete File

```bash
./FileManager.sh deleteFile /tmp/dir1 file2.txt
```
<img width="513" height="87" alt="image" src="https://github.com/user-attachments/assets/38525522-df48-45f5-8af9-c06ac4b35df1" />

# 📋 Example Workflow

```bash
./FileManager.sh addDir /tmp dir1
./FileManager.sh addDir /tmp dir2

./FileManager.sh addFile /tmp/dir1 file1.txt "Hello"

./FileManager.sh addContentToFile /tmp/dir1 file1.txt "Linux"

./FileManager.sh showFileBeginingContent /tmp/dir1 file1.txt 5

./FileManager.sh copyFile /tmp/dir1/file1.txt /tmp/dir2/

./FileManager.sh moveFile /tmp/dir2/file1.txt /tmp/dir2/file2.txt

./FileManager.sh deleteFile /tmp/dir2 file2.txt

./FileManager.sh deleteDir /tmp dir2
```
# ⚠️ Notes

- No `sed` command is used.
- Only basic Linux commands are used.
- The script should validate user input before executing commands.
- Ensure the script has execute permission before running.

**Thank You**
