# isucon8-qualify

## command

execute benchmark

```
xxx
```

create image

```
$ gcloud compute instances stop isucon8-qualifier-web-0 --zone=asia-northeast1-a
$ gcloud compute instances stop isucon8-qualifier-bench-0 --zone=asia-northeast1-a
$ gcloud compute images create isucon8-qualifier-web --source-disk=isucon8-qualifier-web-0 --source-disk-zone=asia-northeast1-a
$ gcloud compute images create isucon8-qualifier-bench --source-disk=isucon8-qualifier-bench-0 --source-disk-zone=asia-northeast1-a
$ gcloud compute instances start isucon8-qualifier-web-0 --zone=asia-northeast1-a
$ gcloud compute instances start isucon8-qualifier-bench-0 --zone=asia-northeast1-a
```

