#!/bin/bash
/usr/pgsql-11/bin/pg_ctl -D /var/lib/pgdata/zup stop
echo "stop cluster zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
rm -rf /var/lib/pgdata/zup/*
echo "start restore zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
NameDirectory=`ls -t1 /pg_backup/zup | grep -oE -m1 .{4}-.{2}-.{2}_.{2}-.{2}`
tar -C '/var/lib/pgdata/zup' -xzvf /pg_backup/zup/$NameDirectory/base.tar.gz
echo "start restore WAL zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
tar -C '/var/lib/pgdata/zup/pg_wal' -xzvf /pg_backup/zup/$NameDirectory/pg_wal.tar.gz
echo "end restore zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
sed -i 's/10.21.128.71/*/' /var/lib/pgdata/zup/postgresql.conf
/usr/pgsql-11/bin/pg_ctl -D /var/lib/pgdata/zup start
echo "start cluster zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log








