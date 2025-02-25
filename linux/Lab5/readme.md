# SSH Key Authentication Setup Guide

Configure passwordless SSH access to a remote VM using cryptographic keys with simplified connection commands.

---

## **Final Objective**
```bash
ssh ivolve  # Single command to connect without specifying user/IP/key
```

---

## **Implementation Steps**

### 1. Generate SSH Key Pair (Local Machine)
```bash
ssh-keygen -t rsa -f ~/.ssh/ivolve_key
```
- `-t ed25519`: Use modern ED25519 algorithm (or `-t rsa -b 4096`)
- `-f ~/.ssh/ivolve_key`: Custom key filename
- *Optional*: Add passphrase for extra security

### 2. Copy Public Key to Remote VM
```bash
ssh-copy-id -i ~/.ssh/ivolve_key.pub user@remote-ip
```
Alternative manual method:
```bash
cat ~/.ssh/ivolve_key.pub | ssh user@remote-ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### 3. Configure SSH Client (Local Machine)
Edit `~/.ssh/config`:
```bash
Host ivolve
    HostName remote-ip
    User remote-username
    IdentityFile ~/.ssh/ivolve_key
    
```

### 4. Set Proper Permissions
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 400 ~/.ssh/ivolve_key*
```

---

## **Verification**
```bash
ssh ivolve  # Should connect without password prompts
```

---

