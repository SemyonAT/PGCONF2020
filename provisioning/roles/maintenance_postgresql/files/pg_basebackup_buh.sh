#!/bin/bash
Date=`date +"%Y-%m-%d_%H-%M"`
echo "backup buh start `date +"%Y-%m-%d %H-%M"`" >> /var/log/maintenance_postgres/backup.log
/usr/pgsql-11/bin/pg_basebackup -h 10.21.128.70 -p 5432 -U barman -D /pg_backup/buh/$Date -Ft -z
echo "backup buh stop  `date +"%Y-%m-%d %H-%M"`" >> /var/log/maintenance_postgres/backup.log








