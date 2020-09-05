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
    cd /tmp/isucon6-qualifier
    echo 'GOOS=linux go build -ldflags "-s -w" -o bin/isupam_linux ./cmd/isupam' > tools/build_isupam.sh
    HOME=/root make
    cd bin
    mv isupam_linux isupam
)
(
    cd /tmp/isucon6-qualifier/provisioning/image
    sed -i -e 's/shutdown/#shutdown/g' init.sh
    sed -i '11,19d' init.sh
    sed -i -e 's/prod/dev/g' init.sh
    sed -i '29,32d' ansible/02_xbuild.yml
    sed -i '21,24d' ansible/02_xbuild.yml
    sed -i '13,16d' ansible/02_xbuild.yml
    sed -i -e 's/ruby-install 2.3.1/ruby-install 2.7.1/g' ansible/02_xbuild.yml
    sed -i -e 's/-5.7//g' ansible/03_mysql.yml
    sed -i -e 's/running/started/g' ansible/03_mysql.yml
    sed -i -e 's/python-mysqldb/python3-mysqldb/g' ansible/03_mysql.yml
    sed -i -e 's/running/started/g' ansible/03_nginx.yml
    sed -i '106,109d' ansible/04_deploy.yml
    sed -i '84,103d' ansible/04_deploy.yml
    sed -i '76,79d' ansible/04_deploy.yml
    sed -i '22,50d' ansible/04_deploy.yml
    sed -i '14,17d' ansible/04_deploy.yml
    sed -i -e 's/ --deployment//g' ansible/04_deploy.yml
    sed -i -e 's/running/started/g' ansible/04_deploy.yml
    rm /tmp/isucon6-qualifier/webapp/ruby/Gemfile.lock
    echo "2.7.1" > /tmp/isucon6-qualifier/webapp/ruby/.ruby-version
    chmod +x init.sh
    ./init.sh
)
systemctl enable isuda.ruby
systemctl start isuda.ruby
systemctl enable isutar.ruby
systemctl start isutar.ruby
usermod -s /bin/bash isucon
echo "startup finish!"
touch ${FILE}
#reboot

