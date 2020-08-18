#!/bin/sh

SEQ=0
if test $# -eq 1; then
    SEQ=$1
fi

gcloud compute ssh "isucon7-qualifier-bench-${SEQ}" --zone "us-central1-a"

