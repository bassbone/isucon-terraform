#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
apt-get update
apt-get -y install ansible git language-pack-ja
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/matsuu/ansible-isucon.git
(
    cd ansible-isucon/isucon7-qualifier
    echo "[imageservers]\nlocalhost ansible_connection=local" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    sed -i -e 's/- webapp-go/#- webapp-go/g' image.yml
    sed -i -e 's/- webapp-node/#- webapp-node/g' image.yml
    sed -i -e 's/- webapp-perl/#- webapp-perl/g' image.yml
    sed -i -e 's/- webapp-php/#- webapp-php/g' image.yml
    sed -i -e 's/- webapp-python/#- webapp-python/g' image.yml
    sed -i -e 's/- python-mysqldb/- python3-mysqldb/g' roles/mysql/tasks/main.yml
    sed -i -e 's/1.9/1.15/g' roles/mysql/tasks/main.yml
    sed -i '48,52d' roles/mysql/tasks/main.yml 
    sed -i -e 's/2.4.2/2.7.1/g' roles/webapp-ruby/tasks/main.yml
    sed -i '19a - file: path=/home/isucon/isubata/webapp/ruby/Gemfile.lock state=absent' roles/webapp-ruby/tasks/main.yml
    ansible-playbook -i local image.yml
)
usermod -s /bin/bash isucon
echo "startup finish!"
touch ${FILE}
#reboot

