#!/bin/bash
/usr/pgsql-11/bin/pg_ctl -D /var/lib/pgdata/buh stop
echo "stop cluster buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
rm -rf /var/lib/pgdata/buh/*
echo "start restore buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
NameDirectory=`ls -t1 /pg_backup/buh | grep -oE -m1 .{4}-.{2}-.{2}_.{2}-.{2}`
tar -C '/var/lib/pgdata/buh' -xzvf /pg_backup/buh/$NameDirectory/base.tar.gz
echo "start restore WAL buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
tar -C '/var/lib/pgdata/buh/pg_wal' -xzvf /pg_backup/buh/$NameDirectory/pg_wal.tar.gz
echo "end restore buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
sed -i 's/10.21.128.70/*/' /var/lib/pgdata/buh/postgresql.conf
/usr/pgsql-11/bin/pg_ctl -D /var/lib/pgdata/buh start
echo "start cluster buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log







