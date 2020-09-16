#!/bin/sh

SEQ=0
if test $# -eq 1; then
    SEQ=$1
fi

gcloud compute ssh "isucon9-final-bench-${SEQ}" --zone "asia-northeast1-a"

