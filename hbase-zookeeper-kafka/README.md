# Intro

This docker is for the running on integrations tests that require hbase, zookeeper and kafka.

It will include a VOLUME that points to your ~/.ivy2 in order to speed up sbt. It will also create
a VOLUME for the source code so that you need to rebuild the docker after updating the code.

You must be in the `hbase-zookeeper-kafka` directory.

# CAVEAT / WARNING

Currently utils.sh need to use sudo to remove a directory, because docker will create everything as root.

# To build

The first time it builds the docker image it will be really slow as it has to run a few wgets.

```
./build-image.sh
```

# To run the integrations tests

As noted you need not rebuild docker when you change your source code. You must be in the `hbase-zookeeper-kafka` directory.

```
./start-docker-and-run-tests.sh
```
