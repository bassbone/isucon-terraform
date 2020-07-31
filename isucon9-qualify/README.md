# isucon9-qualify

## command

```
# IP_WEB=xx.xx.xx.xx
# echo "${IP_WEB} isucon9.catatsuy.org" >> /etc/hosts
```

```
# IP_BENCH=xx.xx.xx.xx
# echo "${IP_BENCH} shipment.isucon9.catatsuy.org" >> /etc/hosts
# echo "${IP_BENCH} payment.isucon9.catatsuy.org" >> /etc/hosts
```

```
$ bin/benchmarker -target-url=https://isucon9.catatsuy.org -payment-url=http://payment.isucon9.catatsuy.org:5555 -shipment-url=http://shipment.isucon9.catatsuy.org:7000
```
