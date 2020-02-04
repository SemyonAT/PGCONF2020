# Test environment for patroni for 1C

* Vagrant file (vagrant up, provision ansible, only linux)

* Ansible script

* Скрипты обслуживания, стартовый набор для тех кто только начинает

# Install

vagrant up

# Use

vagrant ssh pgsrv01

vagrant ssh pgsrv02

vagrant ssh consul

patronictl -c /etc/patroni/postgres-buh.yml list buh
patronictl -c /etc/patroni/postgres-buh.yml list zup
