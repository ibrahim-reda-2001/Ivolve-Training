# Ansible Roles for Installing Jenkins, Docker, and OpenShift CLI

This repository contains Ansible roles to automate the installation of Jenkins, Docker, and the OpenShift CLI (`oc`) on Ubuntu-based systems.

---

## Prerequisites

- Ansible installed on the control machine.
- Target hosts must be running Ubuntu (tested on 20.04/22.04).
- SSH access to the target hosts with sudo privileges.

---

## Role Structure

Organize your Ansible project as follows:
```
ansible/
├── playbook.yml
└── roles/
├── docker/
│ └── tasks/
│ └── main.yml
├── jenkins/
│ └── tasks/
│ └── main.yml
└── openshift/
└── tasks/
└── main.yml
```

---

## Usage

1. **Clone the repository** (or create the role structure manually).
2. **Create a playbook** (`playbook.yml`) to include the roles:
```yaml
---
- hosts: all
  become: yes
  roles:
    - docker
    - jenkins
    - openshift
```
## How to run Playbook
``` bash
ansible-playbook   playbook.yml -i <your inventory>
```
## Verification
1-Docker
``` bash
docker --version
systemctl status docker
```
2-Jenkins
``` bash
java -version
systemctl status jenkins
http://<host-ip>:8080
```
3-OC
``` bash
oc version
kubectl version --client
``` 
