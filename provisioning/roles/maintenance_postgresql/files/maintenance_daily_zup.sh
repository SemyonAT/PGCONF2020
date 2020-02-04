#!/bin/bash
echo "-------------------------------------" >> /var/log/maintenance_postgres/backup.log
echo "start maintenance zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
bases=`psql -qAtX -c "SELECT datname FROM pg_database;" -p5433`
#`psql -qAtXl -p5435 | awk -F'|' '{print $1}'`
for i in $bases
do
    echo "maintenance zup vaccum start data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    /usr/pgsql-11/bin/vacuumdb --analyze -p5433 --dbname=$i
    #--full
    echo "maintenance zup vaccum end   data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    echo "maintenance zup reindex start data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    /usr/pgsql-11/bin/reindexdb --analyze -p5433 --dbname=$i
    echo "maintenance zup reindex end   data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log     
done
echo "stop  maintenance zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
echo "-------------------------------------" >> /var/log/maintenance_postgres/backup.log

