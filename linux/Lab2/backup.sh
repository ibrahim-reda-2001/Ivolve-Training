#!/bin/bash
mysqldump -u root -pPassword --all-databases > /backup/database_$(date +%F).sql
#0 17 * * 0  bash /backup/backup.sh
