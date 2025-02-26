# Ansible Playbook for MySQL Setup with Ansible Vault

## Objective
This Ansible playbook automates the following tasks:
1. Install MySQL Server.
2. Create a database named `ivolve`.
3. Create a user with full privileges on the `ivolve` database.
4. Securely manage sensitive data (e.g., database password) using Ansible Vault.

---

## Prerequisites
- **Ansible** installed on the control node.
- **Sudo privileges** on the target server(s).
- **Ansible Vault** configured (for encrypting sensitive data).
- Target server(s) listed in your Ansible inventory (default: `/etc/ansible/hosts`).

---

