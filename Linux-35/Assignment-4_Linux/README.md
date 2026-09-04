# Assignment-4_linux

# 📂 otssh - SSH Connection Manager

```
                +----------------------+
                |       otssh          |
                +----------+-----------+
                           |
      +--------------------+--------------------+
      |                    |                    |
   Manage             View Connections      Connect
      |                    |                    |
 +----+----+          +----+----+              |
 |    |    |          |         |              |
Add Update Delete    ls      ls -d         otssh <name>
```

---

# ✨ Features

```
✔ Add SSH Connections

✔ List Saved Connections

✔ View Connection Details

✔ Update Existing Connections

✔ Delete Connections

✔ Connect Using Alias

✔ Custom SSH Port Support

✔ SSH Key Authentication
```

---

# 📁 Directory Structure

```
~/.otssh
│
├── connections.db
```

---

# 🖥 Command Syntax

```
otssh [OPTIONS]
```

---

# ➕ Add SSH Connection

```
otssh -a -n <name> -h <host> -u <username>
```

### Example

```
otssh -a -n server1 -h 192.168.21.30 -u kirti
```

Default Port

```
22
```
<img width="584" height="176" alt="image" src="https://github.com/user-attachments/assets/9caeba6a-6864-4112-81a5-f89311ffe41c" />

---

### Custom Port

```
otssh -a -n server2 -h 192.168.42.34 -u kirti -p 2022
```
<img width="613" height="87" alt="image" src="https://github.com/user-attachments/assets/fcb1f0b1-c775-44b3-a6f4-4e16a3646d55" />

---

### Custom Port + Identity File

```
otssh -a -n server3 -h 192.168.46.34 -u ubuntu -p 2022 -i ~/.ssh/server3.pem
```
<img width="812" height="199" alt="WhatsApp Image 2026-08-06 at 10 09 03 PM" src="https://github.com/user-attachments/assets/e01d4892-7bbf-4a9b-b81b-16174eb64c11" />

---

# 📜 List Connections

### Names Only

```
otssh ls
```

```
+---------+
| server1 |
| server2 |
| server3 |
+---------+
```
<img width="302" height="71" alt="image" src="https://github.com/user-attachments/assets/0eb7f32b-df9f-4aa3-afe6-482d2eb93dab" />

---

### Detailed List

```
otssh ls -d
```

```
+--------------------------------------------------------------+
| server1 : ssh kirti@192.168.21.30                            |
|                                                              |
| server2 : ssh -p 2022 kirti@192.168.42.34                    |
|                                                              |
| server3 : ssh -i ~/.ssh/server3.pem -p 2022 ubuntu@192.168.46.34 |
+--------------------------------------------------------------+
```
<img width="561" height="86" alt="image" src="https://github.com/user-attachments/assets/f15f4f55-4c67-41bb-85f4-d24a88e4c0aa" />

---

# ✏ Update Connection

```
otssh -U -n server1 -h server1 -u user1
```

```
otssh -U -n server2 -h server2 -u kirti -p 2022
```

```
ottsh -U -n server3 -h 54.252.233.147 -u ubuntu -i ~/.ssh/key-ec2.pem
```
Verify

```
otssh ls -d
```
<img width="804" height="190" alt="image" src="https://github.com/user-attachments/assets/b8d3f5ce-adf8-475b-822c-e283269a520a" />


---

# ❌ Delete Connection

```
otssh rm server1
```

```
otssh rm server2
```

Verify

```
otssh ls -d
```

```
+------------------------------------------------------+
| server3 : ssh -i ~/.ssh/key-ec2.pem ubuntu@54.252.233.147 |
+------------------------------------------------------+
```
<img width="812" height="128" alt="WhatsApp Image 2026-08-06 at 10 09 04 PM (1)" src="https://github.com/user-attachments/assets/aa4f3e7f-d22c-4054-9636-5ba5851c20c2" />

---

# 🔗 Connect to Server

```
otssh server3
```

Output

```
+------------------------------------------------------+
| Connecting to server3                                |
| Host : 54.252.233.147                                 |
| User : ubuntu                                        |
| Port : 22                                          |
| Key  : home/tanushi/.ssh/key-ec2.pem                            |
+------------------------------------------------------+
```

Executed Command

```
ssh -i ~/.ssh/key-ec2.pem -p 2022 ubuntu@192.168.46.34
```
<img width="812" height="615" alt="WhatsApp Image 2026-08-06 at 10 09 04 PM (2)" src="https://github.com/user-attachments/assets/10c83870-3124-4ec1-860d-3e4bffa2f5b2" />

---

# ⚠ Error Handling

### Connection Not Found

```
otssh server1
```

```
+----------------------------------------------+
| ERROR                                        |
+----------------------------------------------+
| Server information is not available.          |
| Please add the server first.                  |
+----------------------------------------------+
```
<img width="516" height="39" alt="image" src="https://github.com/user-attachments/assets/ea1e0136-95bd-4bff-a6d5-abd62f8a5fcb" />

---

### Duplicate Connection

```
+----------------------------------+
| ERROR                            |
+----------------------------------+
| Server already exists.        |
+----------------------------------+
```
<img width="628" height="44" alt="image" src="https://github.com/user-attachments/assets/e2203cb4-a314-4db6-8f47-145be81aaa92" />

---

### Invalid Command

```
+----------------------------------+
| ERROR                            |
+----------------------------------+
| Invalid command.                 |
| Run: otssh --help               |
+----------------------------------+
```
<img width="812" height="475" alt="WhatsApp Image 2026-08-06 at 10 09 04 PM (4)" src="https://github.com/user-attachments/assets/ae61c0b9-43e8-4f1b-9905-457f9f17ee2c" />

---

# ⚙ Default Values

```
+----------------+----------------+
| Port           | 22             |
+----------------+----------------+
| Identity File  | None           |
+----------------+----------------+
```

---

# 📋 Supported Commands

```
+----------------------+-------------------------------------------+
| Command              | Description                               |
+----------------------+-------------------------------------------+
| otssh -a             | Add a new SSH connection                  |
| otssh ls             | List saved connection names               |
| otssh ls -d          | List saved connections with details       |
| otssh -u             | Update an existing connection             |
| otssh rm <name>      | Delete a saved connection                 |
| otssh <name>         | Connect using saved alias                 |
+----------------------+-------------------------------------------+
```

---

# 🚀 Example Workflow

```
             START
               │
               ▼
        Add Connection
               │
               ▼
       List Connections
               │
               ▼
      View Detailed List
               │
               ▼
      Update Connection
               │
               ▼
      Delete Connection
               │
               ▼
      Connect to Server
               │
               ▼
              END
```

---

# 📦 Requirements

```
✔ Linux

✔ Bash

✔ OpenSSH Client (ssh)
```

---

# 👩‍💻 Author

```
Tanushi Rana
```
