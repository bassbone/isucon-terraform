#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
yum update
yum -y install ansible git
localectl set-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon8-qualify.git
# provisioning
(
    cd isucon8-qualify/provisioning
    sed -i -e 's/1001/2001/g' roles/common/tasks/main.yml
    echo -e "[bench]\nlocalhost ansible_connection=local" > local
    ansible-playbook -i local bench.yml
)
echo "startup finish!"
touch ${FILE}
reboot

