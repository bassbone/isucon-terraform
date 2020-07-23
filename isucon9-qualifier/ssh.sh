#!/bin/sh

if test $# -lt 1; then
    echo "usage: ssh.sh [web or bench]"
    exit 1
fi

gcloud compute ssh "isucon9-qualifier-$1" --zone "asia-northeast1-a"

