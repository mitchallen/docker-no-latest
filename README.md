
## Usage

### Trigger a build

```sh
git checkout main
git tag v1.1.0
git push origin --tags
```

### Run locally

```sh
node server.js
```

### Build docker container

```sh
docker build . -t docker-no-latest
```

### Create a run the container

```sh
docker run -p 3000:3000 --name test-server docker-no-latest
```

### Cleanup

```sh
docker stop no-server
docker rm no-server
docker rmi docker-no-latest
```

## Single line commands

### Create

```sh
docker build . -t docker-no-latest && docker run -p 3000:3000 --name no-server docker-no-latest
```

### Remove

```sh
docker stop no-server && docker rm no-server && docker rmi docker-no-latest
```