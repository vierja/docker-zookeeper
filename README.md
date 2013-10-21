# docker-zookeeper

This is a [Docker](http://docker.io) project to bring up a local
Zookeeper cluster. In addition, the
[Pipework](https://github.com/jpetazzo/pipework) project is used to connect
containers to each other. This is heavily based on [@hectcastro](https://github.com/hectcastro)'s [docker-riak](https://github.com/hectcastro/docker-riak).

## Installation

### Install dependencies

Once you're on a Ubuntu machine, install the following dependencies:

```bash
$ sudo apt-get install -y git curl make
```

## Running

### Clone repository

```bash
$ git clone https://github.com/vierja/docker-zookeeper.git
$ cd docker-zookeeper
$ make
$ make zookeeper-container
```

### Launch cluster

```bash
$ make start-cluster
```

### Tear down cluster

```bash
$ make stop-cluster
```

## Testing

You can use zkClient.sh from the Ubuntu machine connecting to any for the nodes:
```
./zkClient.sh -server 10.0.10.3:2181
```


## Troubleshooting

If you are modifying the amount of nodes in the cluster you may have to rebuild the zookeeper image using `-no-cache` option like:

```
sudo docker build -no-cache -t "vierja/zookeeper" .
```

You also have to modify the `./bin/start-cluster.sh` and the `zoo.cfg` file.