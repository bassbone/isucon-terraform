#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
apt-get update
apt-get -y install ansible git language-pack-ja make golang-go
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon6-qualify.git /tmp/isucon6-qualifier
(
    cd /tmp/isucon6-qualifier/bench
    HOME=/root go mod init bench
    echo $?
    ls -l
    HOME=/root GOOS=linux make
)
(
    cd /tmp/isucon6-qualifier/provisioning/bench
    sed -i '23d' init.sh
    sed -i '11,19d' init.sh
    sed -i -e 's/running/started/g' ansible/04_deploy.yml
    chmod +x init.sh
    ./init.sh
)
usermod -s /bin/bash isucon
echo "startup finish!"
touch ${FILE}
#reboot

