# Ansible Automation Platform Setup Guide

Configure Ansible control nodes and manage infrastructure through ad-hoc commands.

---

## **Prerequisites**
- Control Node: Linux (Python 3.8+)
- Managed Nodes: SSH access (Python installed)
- Sudo privileges on managed hosts

---

## **Installation Steps**

### 1. Install Ansible (Control Node)
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install ansible -y

# RHEL/CentOS
sudo dnf install epel-release
sudo dnf install ansible-core
```

### 2. Verify Installation
```bash
ansible --version
# Should show: ansible [core 2.14.x]
```

---

## **Configuration**

### 1. SSH Key Setup (Passwordless Access)
```bash
ssh-keygen -t rsa -f ~/.ssh/ansible_key
ssh-copy-id -i ~/.ssh/ansible_key.pub user@managed-host
```

### 2. Ansible Configuration File
```bash
sudo nano /etc/ansible/ansible.cfg
```
Add/Modify:
```ini
[defaults]
inventory = /etc/ansible/hosts
private_key_file = ~/.ssh/ansible_key
host_key_checking = False
```

---

## **Inventory Setup**

### 1. Create Inventory File
```bash
sudo nano /etc/ansible/hosts
```
Add:
```ini
[my_servers]
remote-host  ansible_host=192.168.109.156  ansible_user=<user> ansible_private_key_file=~/.ssh/ansible_key

```

### 2. Verify Inventory
```bash
ansible all --list-hosts
```

---

## **Ad-Hoc Commands**

### 1. Connectivity Test
```bash
ansible my_servers -m ping
```

### 2. System Information
```bash
ansible my_servers -a "uptime"
```


### 4. File Operations
```bash
ansible my_servers -m copy -a "src=/local/file.txt dest=/remote/path"
```

### 5. Service Management
```bash
ansible my_servers -b -m service -a "name=httpd state=restarted"
```

---

