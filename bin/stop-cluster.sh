#! /bin/bash

set -e

if sudo docker ps | grep "vierja/zookeeper" >/dev/null; then
  sudo docker ps | grep "vierja/zookeeper" | awk '{ print $1 }' | xargs -r sudo docker kill >/dev/null
  echo "Stopped the cluster and cleared all of the running containers."
fi
