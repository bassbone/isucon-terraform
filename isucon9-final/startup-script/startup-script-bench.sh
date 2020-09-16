#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
apt-get update
apt-get -y install ansible git language-pack-ja make golang-go
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon9-final.git
HOME=/root
(
    cd isucon9-final/bench
    HOME=/root make
    cp -p bin/bench_linux ../ansible/roles/benchmark/files/bench
    cp -p bin/benchworker_linux ../ansible/roles/benchmark/files/benchworker
)
(
    cd isucon9-final/blackbox/payment
    HOME=/root make
    cp -p bin/payment_linux ../../ansible/roles/benchmark/files/payment
)
(
    cd isucon9-final/webapp
    tar cvzf frontend.tar.gz frontend
    cp -p frontend.tar.gz ../ansible/roles/benchmark/files/
)
(
    cd isucon9-final/ansible
    echo "[bench]\nlocalhost ansible_connection=local password='isuconnet'" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    sed -i -e 's/ansible_eth0/ansible_lo/g' roles/common/templates/hosts.j2
    sed -i -e 's/| version_compare/is version_compare/g' roles/docker/tasks/main.yml
    ansible-playbook -i local playbook.yml
)
#usermod -s /bin/bash isucon
echo "startup finish!"
touch ${FILE}
#reboot

