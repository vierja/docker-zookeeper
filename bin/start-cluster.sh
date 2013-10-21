#! /bin/bash

set -e

if sudo docker ps | grep "vierja/zookeeper" >/dev/null; then
  echo ""
  echo "It looks like you already have some containers running."
  echo "Please take them down before attempting to bring up another"
  echo "cluster with the following command:"
  echo ""
  echo "  make stop-cluster"
  echo ""

  exit 1
fi

for index in `seq 5`;
do
  CONTAINER_ID=$(sudo docker run -d -i \
    -h "zoo${index}" \
    -e "ZOO_NODE_NUM=${index}" \
    -t "vierja/zookeeper")

  sleep 3

  sudo ./bin/pipework br1 ${CONTAINER_ID} "10.0.10.${index}/24"

  echo "Started [zoo${index}] and assigned it the IP [10.0.10.${index}]"
  if [ "$index" -eq "1" ] ; then
    #sudo ifconfig br1 10.0.10.254
    sudo ip addr add 10.0.10.254/24 dev br1
  fi
done

sleep 1

