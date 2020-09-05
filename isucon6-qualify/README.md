# isucon6-qualify

## command

execute benchmark

```
xxx
```

create image

```
gcloud compute instances stop isucon6-qualifier-web-0 --zone=asia-northeast1-a
gcloud compute instances stop isucon6-qualifier-bench-0 --zone=asia-northeast1-a
gcloud compute images create isucon6-qualifier-web --source-disk=isucon6-qualifier-web-0 --source-disk-zone=asia-northeast1-a
gcloud compute images create isucon6-qualifier-bench --source-disk=isucon6-qualifier-bench-0 --source-disk-zone=asia-northeast1-a
gcloud compute instances start isucon6-qualifier-web-0 --zone=asia-northeast1-a
gcloud compute instances start isucon6-qualifier-bench-0 --zone=asia-northeast1-a
```

