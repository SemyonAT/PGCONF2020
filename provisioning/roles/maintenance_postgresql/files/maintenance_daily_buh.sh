#!/bin/bash
echo "-------------------------------------" >> /var/log/maintenance_postgres/backup.log
echo "start maintenance buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
bases=`psql -qAtX -c "SELECT datname FROM pg_database;" -p5432`
#`psql -qAtXl -p5435 | awk -F'|' '{print $1}'`
for i in $bases
do
    echo "buh maintenance vaccum start data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    /usr/pgsql-11/bin/vacuumdb --analyze -p5432 --dbname=$i
    #--full
    echo "buh maintenance vaccum end   data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    echo "buh maintenance reindex start data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    /usr/pgsql-11/bin/reindexdb --analyze -p5432 --dbname=$i
    echo "buh maintenance reindex end   data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log     
done
echo "stop  maintenance buh `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
echo "-------------------------------------" >> /var/log/maintenance_postgres/backup.log






