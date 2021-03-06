#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
apt-get update
apt-get -y install ansible git language-pack-ja build-essential unzip
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon9-qualify.git
# update certs
git clone https://github.com/bassbone/isucon9-qualify-extension.git
(
    cd isucon9-qualify-extension/certs
    cp -p isucon.crt /usr/share/ca-certificates/
    echo "isucon.crt" >> /etc/ca-certificates.conf
    update-ca-certificates
)
# make initial-data
apt-get -y install docker.io
(
    cd isucon9-qualify/initial-data
    make
)
apt-get -y remove docker.io
# provisioning
(
    cd isucon9-qualify/provisioning
    sed -i -e 's/1001/2001/g' roles/user.isucon/tasks/main.yml
    echo "[bench]\nlocalhost ansible_connection=local" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    sed -i -e 's/1.13/1.15/g' bench.yml
    ansible-playbook -i local bench.yml
)
(
    cd /home/isucon/isucari/initial-data
    wget -q https://github.com/isucon/isucon9-qualify/releases/download/v2/bench1.zip
    unzip -q bench1.zip
    rm bench1.zip
    rm -rf images
    mv v3_bench1 images
    chown -R isucon:isucon images
)
echo "startup finish!"
touch ${FILE}
#reboot

