# Docker image for Ranzhi
[![Docker Build Status](https://img.shields.io/docker/build/zhangsean/zentao.svg)](https://hub.docker.com/r/zhangsean/zentao/)
[![Docker Pulls](https://img.shields.io/docker/pulls/zhangsean/zentao.svg)](https://hub.docker.com/r/zhangsean/zentao/)
[![Docker Automated build](https://img.shields.io/docker/automated/zhangsean/zentao.svg)](https://hub.docker.com/r/zhangsean/zentao/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/zhangsean/zentao/latest.svg)](https://hub.docker.com/r/zhangsean/zentao/)
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/zhangsean/zentao/latest.svg)](https://hub.docker.com/r/zhangsean/zentao/)

[![DockerHub Badge](http://dockeri.co/image/zhangsean/ranzhi)](https://hub.docker.com/r/zhangsean/ranzhi/)

Auto build docker image for ranzhi, include open source edition and pro edition.

DockerHub: [zhangsean/ranzhi](https://hub.docker.com/r/zhangsean/ranzhi/)

Official Support: [https://www.ranzhi.org/](https://www.ranzhi.org/)

### Tags

**Open soure edition**

- `5.1`,`latest`
- `5.0`

### QuickStart

open soure edition:
``` bash
mkdir -p /data/ranzhi
docker run -d -p 80:80 \
        --add-host smtp.exmail.qq.com:163.177.90.125 \
        -v /data/ranzhi:/opt/zbox \
        --name ranzhi \
        zhangsean/ranzhi:latest
```

### Environment configuration

* `ADMINER_USER` : set the web login database Adminer account.
* `ADMINER_PASSWD` : set the web login database Adminer password.
* `--add-host` : If can't send mail, try to add the smtp server domain and IP.

> Note:
* The Ranzhi administrator account is **admin**, init password is **123456**.
* The MySQL root account init password is **123456**.
* **please change password when you first login.**

### Upgrade Version

> If you want upgrade the ranzhi version, just run a container with the `latest` docker image and mount the same zbox path `$volume/zbox/`.
```bash
# stop and backup old container
docker stop ranzhi
docker rename ranzhi ranzhi-bak
# backup zbox
cp -r /data/ranzhi /data/ranzhi-bak
# pull the latest image
docker pull zhangsean/ranzhi:latest
# run new container with the latest image and mount the same path
docker run -d -p 8080:80 \
        -e ADMINER_USER="root" -e ADMINER_PASSWD="adminer" \
        --add-host smtp.exmail.qq.com:163.177.90.125 \
        -v /data/ranzhi:/opt/zbox \
        --name ranzhi \
        zhangsean/ranzhi:latest
docker logs -f ranzhi
```
You will see the upgrading process logs like following.
```
Installed ranzhi version: 5.0
New ranzhi version: 5.1
Backuping config/my.php and upload ...
Upgrading ranzhi ...
Restoring config/my.php and upload ...
Upgraded ranzhi version to: 5.1
Start Apache success
Start Mysql success
```
Wait until `Start Mysql success`, visit your ranzhi website to complete the upgrade task step by step.

After you complete the upgrade task in your ranzhi website and confirm everything looks good, delete the backups to save your disk space.
```bash
docker rm -f ranzhi-bak
rm -rf /data/ranzhi-bak
```
> [Ranzhi upgrade detail](https://www.ranzhi.org/book/ranzhi/ranzhiupgrade-7.html)

### Building the image

Clone this git,modify `Dockerfile` or `docker-entrypoint` if you want.
Then execute the following command:

```bash
docker build -t ranzhi .
```
