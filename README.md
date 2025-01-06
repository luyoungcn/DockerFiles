
## 基于 Docker 构建 docker 镜像

```bash
docker build -t ubuntu1804:v1 .
docker run --name workstation -di --privileged -v ~/01-coding:/home/deploy/01-coding ubuntu1804:v1
docker exec -it workstation /bin/bash
```
