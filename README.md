# Gogs

Docker image for Gogs self-hosted Git service.

## Build Gogs docker image

### Build with Docker

```shell
docker build -t <username>/gogs .
```

### Build with docker-compose

```shell
docker-compose build
```

## Run dockerized Gogs

### Run as a service

```shell
docker-compose up -d
```

### Run as a stack

1.  Create password files:

    -   mysql/gogs_password.txt
    -   mysql/root_password.txt

2.  Create a Swarm cluster

    ```shell
    docker swarm init
    ```

3.  Deploy the stack

    ```shell
    docker stack deploy -c docker-compose.yml gogs
    ```
