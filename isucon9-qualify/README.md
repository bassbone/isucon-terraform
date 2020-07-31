# isucon9-qualify

## command

for bench server

```
# IP=xx.xx.xx.xx
# echo "${IP} isucon9.catatsuy.org" >> /etc/hosts && cat /etc/hosts
```

for web server

```
# IP=xx.xx.xx.xx
# echo "${IP} external.isucon9.catatsuy.org" >> /etc/hosts && cat /etc/hosts
```

execute benchmark

```
$ bin/benchmarker -target-url=https://isucon9.catatsuy.org -payment-url=http://external.isucon9.catatsuy.org:5555 -shipment-url=http://external.isucon9.catatsuy.org:7000
```

create image

```
$ gcloud compute instances stop isucon9-qualifier-web-0 --zone=asia-northeast1-a
$ gcloud compute instances stop isucon9-qualifier-bench-0 --zone=asia-northeast1-a
$ gcloud compute images create isucon9-qualifier-web --source-disk=isucon9-qualifier-web-0 --source-disk-zone=asia-northeast1-a
$ gcloud compute images create isucon9-qualifier-bench --source-disk=isucon9-qualifier-bench-0 --source-disk-zone=asia-northeast1-a
$ gcloud compute instances start isucon9-qualifier-web-0 --zone=asia-northeast1-a
$ gcloud compute instances start isucon9-qualifier-bench-0 --zone=asia-northeast1-a
```

```
$ gcloud compute ssh "isucon9-qualifier-web-0" --zone "asia-northeast1-a" --command="sudo systemctl disable isucari.golang.service && sudo systemctl enable isucari.ruby.service && sudo reboot"
$ gcloud compute ssh "isucon9-qualifier-web-1" --zone "asia-northeast1-a" --command="sudo systemctl disable isucari.golang.service && sudo systemctl enable isucari.ruby.service && sudo reboot"
$ gcloud compute ssh "isucon9-qualifier-web-2" --zone "asia-northeast1-a" --command="sudo systemctl disable isucari.golang.service && sudo systemctl enable isucari.ruby.service && sudo reboot"
```
