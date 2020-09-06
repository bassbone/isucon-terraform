# isucon9-qualify

## command

execute benchmark

```
xxx
```

create image

```
gcloud compute instances stop isucon9-qualifier-web-0 --zone=asia-northeast1-a
gcloud compute instances stop isucon9-qualifier-bench-0 --zone=asia-northeast1-a
gcloud compute images create isucon9-qualifier-web-v2 --source-disk=isucon9-qualifier-web-0 --source-disk-zone=asia-northeast1-a
gcloud compute images create isucon9-qualifier-bench-v2 --source-disk=isucon9-qualifier-bench-0 --source-disk-zone=asia-northeast1-a
gcloud compute instances start isucon9-qualifier-web-0 --zone=asia-northeast1-a
gcloud compute instances start isucon9-qualifier-bench-0 --zone=asia-northeast1-a
```

