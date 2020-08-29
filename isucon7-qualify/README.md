# isucon7-qualify

## command

execute benchmark

```
xxx
```

create image

```
gcloud compute instances stop isucon7-qualifier-web-0 --zone=asia-northeast1-a
gcloud compute instances stop isucon7-qualifier-bench-0 --zone=asia-northeast1-a
gcloud compute images create isucon7-qualifier-web --source-disk=isucon7-qualifier-web-0 --source-disk-zone=asia-northeast1-a
gcloud compute images create isucon7-qualifier-bench --source-disk=isucon7-qualifier-bench-0 --source-disk-zone=asia-northeast1-a
gcloud compute instances start isucon7-qualifier-web-0 --zone=asia-northeast1-a
gcloud compute instances start isucon7-qualifier-bench-0 --zone=asia-northeast1-a
```

