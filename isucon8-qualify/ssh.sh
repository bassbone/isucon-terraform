#!/bin/sh

if test $# -lt 1; then
    echo "usage: ssh.sh [web or bench] [number:default 0]"
    exit 1
fi

SEQ=0
if test $# -eq 2; then
    SEQ=$2
fi

gcloud compute ssh "isucon8-qualifier-$1-${SEQ}" --zone "asia-northeast1-a"

