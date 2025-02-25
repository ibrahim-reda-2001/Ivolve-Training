# MySQL Database Backup Automation

This guide explains how to set up automated backups for all MySQL databases using a cron job.

---

## **Overview**
- Creates compressed SQL backups of all MySQL databases
- Stores backups in `/backup` directory with date-stamped filenames
- Automates weekly backups (every Sunday at 5:00 PM)

---

## **Setup Instructions**

### 1. Create Backup Directory
```bash
sudo mkdir -p /backup
sudo chmod 700 /backup  # Restrict directory permissions
```

### 2. Create Backup Script
Create `/backup/backup.sh` with the following content:
```bash
#!/bin/bash
mysqldump -u root -pPassword --all-databases > /backup/database_$(date +%F).sql
```

Make the script executable:
```bash
sudo chmod +x /backup/backup.sh
```

### 3. Schedule with Cron
Add to crontab:
```bash
sudo crontab -e
```

Add this line to run weekly at Sunday 5:00 PM:
```bash
0 17 * * 0 /bin/bash /backup/backup.sh
```

---

## **Security Considerations**
1. **Password Protection**:
   - Currently uses plaintext password (consider using `mysql_config_editor` instead)
   - Restrict script permissions:
     ```bash
     sudo chmod 700 /backup/backup.sh
     ```

2. **Backup Storage**:
   - Ensure `/backup` directory is secure
   - Consider encrypting backups
   - Implement retention policy

---

## **Verification**
1. Manually test the script:
```bash
sudo /backup/backup.sh
```

2. Check backup file:
```bash
ls -l /backup/database_*.sql
```

3. Verify cron job:
```bash
sudo grep CRON /var/log/syslog
```

---

## **Troubleshooting**
**Common Issues**:
- `Permission denied` errors:
  ```bash
  sudo chown root:root /backup/backup.sh
  ```
  
- MySQL connection issues:
  - Verify MySQL credentials
  - Test manual mysqldump
  
- Cron job not executing:
  ```bash
  systemctl status cron
  ```

---

## **Customization Options**
1. **Add Compression**:
```bash
# Modify script to:
mysqldump -u root -pPassword --all-databases | gzip > /backup/database_$(date +%F).sql.gz
```

2. **Retention Policy** (keep 30 days):
```bash
# Add to script:
find /backup -name "database_*.sql" -mtime +30 -delete
```

3. **Email Notifications**:
```bash
# Add to script:
echo "Backup completed" | mail -s "MySQL Backup Report" admin@example.com
```

---

**Note**: Replace `Password` with your actual MySQL root password. For production environments, consider using MySQL user with limited privileges specifically for backups.