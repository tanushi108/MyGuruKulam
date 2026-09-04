# Asssignment-5_Ansible

# Kubernetes Cluster Setup Using Ansible

This project automates the installation and configuration of Kubernetes components on Linux servers using **Ansible**.

The playbook supports **Debian-based** and **Red Hat-based** systems and uses **containerd** as the container runtime.

## Project Overview

The automation performs the following tasks:

* Installs Kubernetes packages
* Configures the Kubernetes repository
* Installs `kubeadm`, `kubelet`, and `kubectl`
* Disables swap
* Enables IPv4 forwarding
* Installs and configures containerd
* Configures kubelet
* Starts and enables required services
* Initializes a Kubernetes cluster on the selected control-plane server
* Configures `kubectl`

## Technologies Used

* Ansible
* Kubernetes
* kubeadm
* kubelet
* kubectl
* containerd
* Linux
* YAML

## Project Structure

```text
ansible/
├── inventory
├── assignment.yml
└── kubernetes/
    ├── tasks/
    │   ├── Debian.yml
    │   └── RedHat.yml
    ├── templates/
    │   └── kubelet.conf.j2
    ├── handlers/
    │   └── main.yml
    └── vars/
        └── main.yml
```


## Requirements

Before running the playbook, make sure:

* Ansible is installed on the control machine
* SSH access is configured for the target servers
* Target servers have `sudo` privileges
* Target servers have network access to Kubernetes repositories
* Sufficient system resources are available for Kubernetes


## Running the Playbook

Check the inventory syntax:

```bash
ansible-inventory -i inventory --syntax_check
```

<img width="882" height="99" alt="image" src="https://github.com/user-attachments/assets/bb84dd3b-b75b-48aa-bc5c-2306de19c961" />


Test connectivity:

```bash
ansible -i inventory app -m ping
```
<img width="693" height="228" alt="image" src="https://github.com/user-attachments/assets/af78aa64-6e15-42a5-9118-6581c0a37a52" />

Run the playbook:

```bash
ansible-playbook app -i inventory assignment-5.yml
```



<img width="1301" height="579" alt="image" src="https://github.com/user-attachments/assets/b8f25024-f0f9-4c06-bb43-3c65391586a8" />

<img width="1304" height="555" alt="image" src="https://github.com/user-attachments/assets/290654de-9872-4698-a8f5-475e01c550f9" />

<img width="1286" height="356" alt="image" src="https://github.com/user-attachments/assets/69314445-0f6a-42a0-a7f4-458e3e7ca813" />


<img width="1104" height="542" alt="image" src="https://github.com/user-attachments/assets/fd6be05a-7527-458c-9a40-f4f617d51d9d" />

<img width="1275" height="430" alt="image" src="https://github.com/user-attachments/assets/429aa2da-cb63-4c1f-93dd-7ebc5d98164d" />




## Verify Installation

Check Kubernetes versions:

```bash
ansible -i inventory Debian_server -m shell \
  -a "kubeadm version; kubelet --version; kubectl version --client"

ansible -i inventory app -m shell \
  -a "kubeadm version; kubelet --version; kubectl version --client"
```

<img width="1297" height="156" alt="image" src="https://github.com/user-attachments/assets/f670dc94-8306-4d2f-a45c-b88192b6c280" />

<img width="1302" height="306" alt="image" src="https://github.com/user-attachments/assets/abf4c1bf-c648-407e-837c-b099d00af254" />

Check containerd:

```bash
ansible -i inventory Debian_server -m shell \
  -a "sudo systemctl is-active containerd"
```

Check kubelet:

```bash
ansible -i inventory Debian_server -m shell \
  -a "sudo systemctl is-active kubelet"
```

<img width="810" height="199" alt="image" src="https://github.com/user-attachments/assets/6bbdbd56-569a-488f-96ef-ec467197bd1c" />


Check containers:

```bash
ansible -i inventory Debian_server -m shell \
  -a "sudo crictl --runtime-endpoint unix:///run/containerd/containerd.sock ps -a"
```
<img width="1294" height="125" alt="image" src="https://github.com/user-attachments/assets/01a6c642-68d9-4e7a-a837-f3d16f0eb6b2" />



---

## Conclusion

The `kubernetes` Ansible role automates Kubernetes package installation across different Linux operating systems.

The role supports version-specific installation, OS-independent execution, variableized configuration, separate OS-specific task files, and separate handlers.

By separating Debian and RedHat tasks, the same role can be executed on Ubuntu, CentOS/RHEL, or both without changing the main role logic.

