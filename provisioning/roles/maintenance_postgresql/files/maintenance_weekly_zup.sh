#!/bin/bash
echo "-------------------------------------" >> /var/log/maintenance_postgres/backup.log
echo "weekly start maintenance zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
bases=`psql -qAtX -c "SELECT datname FROM pg_database;" -p5433`
#`psql -qAtXl -p5435 | awk -F'|' '{print $1}'`
for i in $bases
do
    echo "weekly maintenance zup vaccum full start data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
    /usr/pgsql-11/bin/vacuumdb --analyze --full -p5433 --dbname=$i
    echo "weekly maintenance zup vaccum full end   data bases $i `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log    
done
echo "weekly stop  maintenance zup `date +"%Y-%m-%d_%H-%M"`" >> /var/log/maintenance_postgres/backup.log
echo "-------------------------------------" >> /var/log/maintenance_postgres/backup.log



