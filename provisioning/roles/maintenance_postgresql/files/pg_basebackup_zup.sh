#!/bin/bash
Date=`date +"%Y-%m-%d_%H-%M"`
echo "backup zup start `date +"%Y-%m-%d %H-%M"`" >> /var/log/maintenance_postgres/backup.log
/usr/pgsql-11/bin/pg_basebackup -h 10.21.128.71 -p 5433 -U barman -D /pg_backup/zup/$Date -Ft -z
echo "backup zup stop  `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log








