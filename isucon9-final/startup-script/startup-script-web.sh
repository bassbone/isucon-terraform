#!/bin/sh
FILE=/initialized.txt
if [ -e ${FILE} ]; then
    exit 0
fi
apt-get update
apt-get -y install ansible git language-pack-ja make
update-locale LANG=ja_JP.UTF-8
git clone https://github.com/isucon/isucon9-final.git
(
    cd isucon9-final
    tar cvzf webapp.tar.gz webapp
    cp -p webapp.tar.gz ansible/roles/challenge/files/
)
(
    cd isucon9-final/webapp
    tar cvzf frontend.tar.gz frontend
    cp -p frontend.tar.gz ../ansible/roles/challenge/files/
)
(
    cd isucon9-final/ansible
    echo "[user]\nlocalhost ansible_connection=local password='isuconnet' payment_api='https://payment.isucon9.hinatan.net'" > local
    echo "[defaults]\nremote_tmp = /root/.ansible/tmp" > ansible.cfg
    sed -i -e 's/ansible_eth0/ansible_lo/g' roles/common/templates/hosts.j2
    sed -i -e 's/| version_compare/is version_compare/g' roles/docker/tasks/main.yml
    sed -i -e 's/ mem=1G//g' roles/challenge/templates/grub
    echo '- file: path=/home/isucon/isutrain/webapp/ruby/Gemfile.lock state=absent' >> roles/challenge/tasks/main.yml
    ansible-playbook -i local playbook.yml
)
(
    cd isucon9-final
    cp -pr blackbox /home/isucon/isutrain/
)
systemctl stop isutrain-go.service
systemctl start isutrain-ruby.service
echo "startup finish!"
touch ${FILE}
#reboot

