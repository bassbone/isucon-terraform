# isucon9-qualify

## command

```
# IP_WEB=xx.xx.xx.xx
# echo "${IP_WEB} isucon9.catatsuy.org" >> /etc/hosts
# cat /etc/hosts
```

```
# IP_BENCH=xx.xx.xx.xx
# echo "${IP_BENCH} shipment.isucon9.catatsuy.org" >> /etc/hosts
# echo "${IP_BENCH} payment.isucon9.catatsuy.org" >> /etc/hosts
# cat /etc/hosts
```

```
$ gcloud compute ssh "isucon9-qualifier-web-0" --zone "asia-northeast1-a" --command="sudo systemctl disable isucari.golang.service && sudo systemctl enable isucari.ruby.service && sudo reboot"
$ gcloud compute ssh "isucon9-qualifier-web-1" --zone "asia-northeast1-a" --command="sudo systemctl disable isucari.golang.service && sudo systemctl enable isucari.ruby.service && sudo reboot"
$ gcloud compute ssh "isucon9-qualifier-web-2" --zone "asia-northeast1-a" --command="sudo systemctl disable isucari.golang.service && sudo systemctl enable isucari.ruby.service && sudo reboot"
```

```
$ bin/benchmarker -target-url=https://isucon9.catatsuy.org -payment-url=http://payment.isucon9.catatsuy.org:5555 -shipment-url=http://shipment.isucon9.catatsuy.org:7000
```
