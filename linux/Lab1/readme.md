# README: Configure User and Permissions for Installing Nginx

This guide outlines the steps to create a new group (`ivolve`), add a user to this group, and configure permissions to allow installing Nginx with `sudo` without a password.

---

## **Steps to Complete the Task**

### **1. Create the `ivolve` Group**
Create a new group named `ivolve`:
```bash
sudo groupadd ivolve
```

### **2. Create a New User and Assign to the `ivolve` Group**
```bash
sudo useradd -m -G ivolve ibra
```
- `-m`: Creates a home directory for the user.
- `-G ivolve`: Adds the user to the `ivolve` group.

### **3. Set a Secure Password for the User**
Set a password for the user:
```bash
sudo passwd ibra
```
Follow the prompts to set a **secure password** (e.g., a mix of uppercase, lowercase, numbers, and symbols).

### **4. Configure Passwordless Sudo for Installing Nginx**
Allow the `ivolve` group to run `apt install nginx` without a password:
```bash
sudo visudo
```
Add the following line at the **end** of the file:
```bash
%ivolve ALL=(ALL) NOPASSWD: /usr/bin/apt install nginx
```
- Save and exit (`Ctrl+O` → `Enter` → `Ctrl+X` if using `nano`).

### **5. Verify the Configuration**
Test the setup:
```bash
su - ibra  # Switch to the new user
sudo apt install nginx  # Should run without a password prompt
```

---

## **Key Notes**
1. **Security**: Granting passwordless `sudo` privileges exposes a security risk. Limit this to trusted users and specific commands.
2. **Group Membership**: The user may need to log out and back in for group changes to take effect.
3. **Package Manager**: This guide assumes `apt` is used (Debian/Ubuntu). Adjust the command path (e.g., `/usr/bin/apt-get`) if needed for your system.

---

## **Troubleshooting**
- **"User is not in the sudoers file"**: Ensure the user is in the `ivolve` group with:
  ```bash
  groups ibra
  ```
- **Sudoers Syntax Errors**: Always use `sudo visudo` to edit the sudoers file to avoid syntax issues.

---

**Done!** The user `ibra` can now install Nginx with `sudo apt install nginx` without a password.