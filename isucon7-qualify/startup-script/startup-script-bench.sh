#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
apt-get update
apt-get -y install ansible git
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/matsuu/ansible-isucon.git
(
    cd ansible-isucon/isucon7-qualifier
    echo "[benchservers]\nlocalhost ansible_connection=local" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    ansible-playbook -i local bench.yml
)
usermod -s /bin/bash isucon
echo "startup finish!"
touch ${FILE}
reboot

