# Assignment-6_Linux

## 🎯 Objective

Practice **Linux process management, monitoring, scheduling, and service management** by creating shell-script based process management utilities.

The assignment is divided into three parts:

* 🔹 **Part A:** Process Management Utility
* 🔹 **Part B:** Process Manager Utility
* 🔹 **Part C:** Practical Process Management

---

# 📂 Part A: Process Management Utility

## 🎯 Objective

Create a process management utility named **`otProcessManager`** to monitor and manage processes running on a Linux system.

### 📌 Utility Syntax

```bash
./otProcessManager <operation> [arguments]
```

---

## 📍 Task 1: Top N Processes by Memory

Find the top **N processes** based on memory consumption.

### 🔹 Command

```bash
./otProcessManager topProcess 5 memory
```

### 📝 Example

```text
Top 5 processes by memory
```

<img width="532" height="141" alt="image" src="https://github.com/user-attachments/assets/221a54e9-48e6-47d9-92e7-97608d12dbd8" />


---

## 📍 Task 2: Top N Processes by CPU

Find the top **N processes** based on CPU consumption.

### 🔹 Command

```bash
./otProcessManager topProcess 10 cpu
```

### 📝 Example

```text
Top 10 processes by CPU
```

<img width="561" height="226" alt="image" src="https://github.com/user-attachments/assets/2fa7587e-24a3-4cc7-9e1b-9d576c08efd8" />

---

## 📍 Task 3: Kill Process Having Least Priority

Find and terminate the process having the lowest priority.

### 🔹 Command

```bash
./otProcessManager killLeastPriorityProcess
```
<img width="534" height="54" alt="image" src="https://github.com/user-attachments/assets/3d03f82b-95e2-4002-8145-3143f85df899" />

---

## 📍 Task 4: Find Running Duration of a Process

Find how long a particular process has been running.

### 🔹 Using Process Name

```bash
./otProcessManager RunningDurationProcess <processName>
```

### 🔹 Using Process ID

```bash
./otProcessManager RunningDurationProcess <processID>
```

### 📝 Example

```bash
./otProcessManager RunningDurationProcess slack
```

or

```bash
./otProcessManager RunningDurationProcess 7213
```


<img width="645" height="280" alt="image" src="https://github.com/user-attachments/assets/cfdd1f3e-8f04-417d-a03a-2079ba367772" />

---

## 📍 Task 5: List Orphan Processes

Find orphan processes running on the system.

### 🔹 Command

```bash
./otProcessManager listOrphanProcess
```

### 📖 Definition

An **orphan process** is a process whose parent process has terminated while the child process is still running.

<img width="645" height="598" alt="image" src="https://github.com/user-attachments/assets/c612c11c-1fa3-47cf-9b69-6129ff859a9b" />

---

## 📍 Task 6: List Zombie Processes

Find zombie processes running on the system.

### 🔹 Command

```bash
./otProcessManager listZoombieProcess
```

### 📖 Definition

A **zombie process** is a process that has completed execution but still has an entry in the process table because its parent has not collected its exit status.

<img width="628" height="38" alt="image" src="https://github.com/user-attachments/assets/4b6fd0ba-9f31-420f-840f-e659d63e3924" />

---

## 📍 Task 7: Kill Process by Name or PID

Terminate a process using either its name or PID.

### 🔹 Using Process Name

```bash
./otProcessManager killProcess <processName>
```

### 🔹 Using Process ID

```bash
./otProcessManager killProcess <processID>
```

### 📝 Example

```bash
./otProcessManager killProcess snap-store
```

or

```bash
./otProcessManager killProcess 10289
```

<img width="549" height="68" alt="image" src="https://github.com/user-attachments/assets/65d90d0c-5d16-42cc-93b1-4898537e5b0c" />

---

## 📍 Task 8: List Processes Waiting for Resources

Find processes that are currently waiting for resources.

### 🔹 Command

```bash
./otProcessManager ListWaitingProcess
```

<img width="587" height="67" alt="image" src="https://github.com/user-attachments/assets/dee83b45-1523-4cde-8a7c-6dbad2e6acdd" />


---

# 📂 Part B: Process Manager Utility

## 🎯 Objective

Create a **`ProcessManager.sh`** utility that can register scripts as services and manage those services.

The utility should support:

* 📝 Register a service
* ▶️ Start a service as a daemon
* 🔍 Check service status
* 🛑 Stop a service
* ⚡ Change process priority
* 📋 List registered services
* 📊 Display process details

## 📍 Task 1: Register a Service

Register a script with a service alias.

### 🔹 Command

```bash
./ProcessManager.sh -o register -s <path> -a <alias>
```

### 📝 Example

```bash
./ProcessManager.sh -o register -s /home/user/service1.sh -a service1
```

### 📖 Explanation

* `-o register` → Register operation
* `-s` → Script path
* `-a` → Service alias

<img width="673" height="75" alt="WhatsApp Image 2026-08-11 at 2 39 23 PM" src="https://github.com/user-attachments/assets/e832a7c0-98fb-4779-9309-85ae408881ee" />

---

## 📍 Task 2: Start a Service

Start the registered service as a daemon/background process.

### 🔹 Command

```bash
./ProcessManager.sh -o start -a <alias>
```

### 📝 Example

```bash
./ProcessManager.sh -o start -a service1
```

<img width="505" height="56" alt="image" src="https://github.com/user-attachments/assets/9677baa9-c8e2-4c3b-a411-be2af889d1bf" />

## 📍 Task 3: Check Service Status

Check whether a particular service is running.

### 🔹 Command

```bash
./ProcessManager.sh -o status -a <alias>
```

### 📝 Example

```bash
./ProcessManager.sh -o status -a service1
```

### 💡 Expected Output

```text
service1 is running
PID: 2456
```

If the service is stopped:

```text
service1 is not running
```

<img width="525" height="93" alt="image" src="https://github.com/user-attachments/assets/78e833a3-363f-4819-adb3-cc49271622d7" />

---

## 📍 Task 4: Stop a Service

Stop a particular service.

### 🔹 Command

```bash
./ProcessManager.sh -o kill -a <alias>
```

### 📝 Example

```bash
./ProcessManager.sh -o kill -a service1
```
<img width="673" height="135" alt="image" src="https://github.com/user-attachments/assets/91124629-34a4-448d-9bde-eeedb5edb73e" />

---

## 📍 Task 5: Change Process Priority

Change the priority of a service.

### 🔹 Command

```bash
./ProcessManager.sh -o priority -p <low/med/high> -a <alias>
```

### 📝 Examples

```bash
./ProcessManager.sh -o priority -p low -a service1
```

```bash
./ProcessManager.sh -o priority -p med -a service1
```

```bash
./ProcessManager.sh -o priority -p high -a service1
```
<img width="673" height="237" alt="image" src="https://github.com/user-attachments/assets/da30bd04-8a62-40b8-a479-b1c53b79443b" />

---

## 📊 Figure 5: Process Priority

```mermaid
flowchart LR
    A["Service Process"] --> B{"Priority"}

    B --> C["Low"]
    B --> D["Medium"]
    B --> E["High"]

    C --> F["Lower Scheduling Preference"]
    D --> G["Normal Scheduling Preference"]
    E --> H["Higher Scheduling Preference"]
```

> 💡 Linux process priority is commonly controlled using the **nice value**. A lower nice value generally gives a process a higher scheduling priority.

---

## 📍 Task 6: List Registered Services

Display all services registered with the utility.

### 🔹 Command

```bash
./ProcessManager.sh -o list
```

### 📝 Example Output

```text
service2
service1
service3
```

<img width="671" height="258" alt="image" src="https://github.com/user-attachments/assets/1d2d2159-c6a6-491b-9cb8-78173f6c3a87" />

<img width="673" height="294" alt="image" src="https://github.com/user-attachments/assets/ed1157fc-60ec-405c-a2a2-646f83647c83" />

---

## 📍 Task 7: Display Process Details

Display details of all processes started by the utility.

### 🔹 Command

```bash
./ProcessManager.sh -o top
```

To display details of a particular service:

```bash
./ProcessManager.sh -o top -a <alias>
```

<img width="540" height="236" alt="image" src="https://github.com/user-attachments/assets/5a6ca519-ce1a-4f99-89b1-c468134c5909" />

---

## 📊 Figure 6: Process Details

```mermaid
flowchart TD
    A["Process Details"] --> B["Alias"]
    A --> C["PID"]
    A --> D["State"]
    A --> E["Priority"]
    A --> F["Script"]

    B --> G["Service Information"]
    C --> G
    D --> G
    E --> G
    F --> G
```

---

# 📂 Part C: Play Around With Processes

## 🎯 Objective

Perform practical experiments to understand how Linux handles processes, log files, file descriptors, and process priorities.

---

## 📍 Task 1: Display Running Process

First identify the running process:

```bash
ps -ef
```
<img width="866" height="405" alt="image" src="https://github.com/user-attachments/assets/c6077edf-77fa-4bfb-89eb-bdaccbab4584" />

Clear the contents of the log file:
```bash 
> application.log
```
or:

```bash
truncate -s 0 application.log
```
### 📖 Observation

The process continues running because only the contents of the log file are cleared.

---

## 📍 Task 2: Delete a Log File of a Running Process

### Delete the log file:

```bash
rm application.log
```

Check whether the running process still has the deleted file open:

```bash
lsof | grep deleted
```

### 📖 Observation

If a running process has the file open, deleting the file name does not immediately terminate the process.

The process can continue using its open file descriptor.

--- 
## 📍 Task 3: Elevate the Priority of a Process

### 🔹 Display Processes

```bash
ps -ef
```

### 🔹 Display Detailed Process Information

```bash
ps -eo pid,ppid,user,%cpu,%mem,stat,ni,comm
```

<img width="673" height="515" alt="image" src="https://github.com/user-attachments/assets/86672738-5caf-412b-8997-c4137d0467c8" />


### 🔹 Change Process Priority

```bash
renice -n <value> -p <PID>
```

<img width="490" height="400" alt="image" src="https://github.com/user-attachments/assets/a2c4b144-e342-4f7c-b9f8-6f433569b838" />

---


# ▶️ Execution

## 🔹 Give Execute Permission

```bash
chmod +x otProcessManager
chmod +x ProcessManager.sh
```

## 🔹 Run Part A

```bash
./otProcessManager topProcess 5 memory
```

## 🔹 Register a Service

```bash
./ProcessManager.sh -o register -s /path/to/service.sh -a service1
```

## 🔹 Start the Service

```bash
./ProcessManager.sh -o start -a service1
```

## 🔹 Check Status

```bash
./ProcessManager.sh -o status -a service1
```

## 🔹 Display Process Details

```bash
./ProcessManager.sh -o top
```

## 🔹 Stop the Service

```bash
./ProcessManager.sh -o kill -a service1
```

---

# 🎓 Learning Outcomes

After completing this assignment, you will be able to:

* ✅ Monitor CPU and memory usage of processes.
* ✅ Find and manage processes using PID and process name.
* ✅ Identify orphan processes.
* ✅ Identify zombie processes.
* ✅ Find processes waiting for resources.
* ✅ Understand process priority and nice values.
* ✅ Start and manage daemon processes.
* ✅ Register and manage services using a Bash utility.
* ✅ Check process status.
* ✅ Change process priority.
* ✅ Understand Linux file descriptors.
* ✅ Understand the effect of clearing and deleting files used by running processes.

---

# 🚫 Important Notes

* 🐧 The assignment should be performed on a Linux system.
* 🔐 Some process-management operations may require `sudo`.
* ⚡ Be careful while using `kill` and `renice` on system processes.
* 📝 Test process-management commands on safe/user-created processes whenever possible.

---

# 🏁 Assignment Summary

| Part      | Topic                           | Utility             |
| --------- | ------------------------------- | ------------------- |
| 📌 Part A | Process Monitoring & Management | `otProcessManager`  |
| 📌 Part B | Service Management              | `ProcessManager.sh` |
| 📌 Part C | Process Experiments             | Linux Commands      |


## 🏁 Happy Learning! 🚀
