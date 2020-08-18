#!/bin/sh

SEQ=0
if test $# -eq 1; then
    SEQ=$1
fi

gcloud compute ssh "isucon7-qualifier-web-${SEQ}" --zone "asia-northeast1-a"

