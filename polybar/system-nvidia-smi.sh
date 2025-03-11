#!/bin/sh

nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ printf("GPU %2d%s", $1, "%") }'
