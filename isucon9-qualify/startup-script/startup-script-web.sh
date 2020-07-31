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
    cp -p *.pem /isucon9-qualify/provisioning/certs/isucon9.catatsuy.org/
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
    sed -i -e 's/- perl/#- perl/g' webapp.yml
    sed -i -e 's/- webapp.perl/#- webapp.perl/g' webapp.yml
    sed -i -e 's/- php/#- php/g' webapp.yml
    sed -i -e 's/- webapp.php/#- webapp.php/g' webapp.yml
    sed -i -e 's/- nodejs/#- nodejs/g' webapp.yml
    sed -i -e 's/- webapp.nodejs/#- webapp.nodejs/g' webapp.yml
    sed -i -e 's/- python/#- python/g' webapp.yml
    sed -i -e 's/- webapp.python/#- webapp.python/g' webapp.yml
    echo "[webapp]\nlocalhost ansible_connection=local" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    ansible-playbook -i local webapp.yml
)
# update image
(
    cd /home/isucon/isucari/webapp/public
    wget -q https://github.com/isucon/isucon9-qualify/releases/download/v2/initial.zip
    unzip -q initial.zip
    rm initial.zip
    rm -rf upload
    mv v3_initial_data upload
    chown -R isucon:isucon upload
)
systemctl disable isucari.golang.service
systemctl enable isucari.ruby.service
echo "startup finish!"
touch ${FILE}
reboot

