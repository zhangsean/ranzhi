# Docker image for Ranzhi
[![Docker Pulls](https://img.shields.io/docker/pulls/zhangsean/ranzhi.svg)](https://hub.docker.com/r/zhangsean/ranzhi)
[![Docker Automated build](https://img.shields.io/docker/automated/zhangsean/ranzhi.svg)](https://hub.docker.com/r/zhangsean/ranzhi)
[![Docker Build Status](https://img.shields.io/docker/build/zhangsean/ranzhi.svg)](https://hub.docker.com/r/zhangsean/ranzhi)
[![ImageLayers Size](https://img.shields.io/microbadger/image-size/zhangsean/ranzhi/latest.svg)](https://hub.docker.com/r/zhangsean/ranzhi)
[![ImageLayers Layers](https://img.shields.io/microbadger/layers/zhangsean/ranzhi/latest.svg)](https://hub.docker.com/r/zhangsean/ranzhi)

[![DockerHub Badge](https://dockeri.co/image/zhangsean/ranzhi)](https://hub.docker.com/r/zhangsean/ranzhi)

Auto build docker image for ranzhi, include open source edition and pro edition.

DockerHub: [zhangsean/ranzhi](https://hub.docker.com/r/zhangsean/ranzhi/)

Official Support: [https://www.ranzhi.org/](https://www.ranzhi.org/)

### Tags

**Open soure edition**

- `v5.2`,`latest` Ranzhi v5.2
- `v5.1` Ranzhi v5.1
- `v5.0` Ranzhi v5.0

### Quick start

open soure edition:
``` bash
mkdir -p /data/ranzhi
docker run -d -p 80:80 \
       -e ADMINER_USER="root" -e ADMINER_PASSWD="adminer" \
       --add-host smtp.exmail.qq.com:163.177.90.125 \
       -v /data/ranzhi:/opt/zbox \
       --name ranzhi \
       zhangsean/ranzhi:latest
```

### Available web:
* Ranzhi: http://server/ or http://server/ranzhi/
* Adminer: http://server/adminer/

> Note:
* The Ranzhi administrator account is **admin**, initial password is **123456**.
* The MySQL root account initial password is **123456**.
* **Please change the initial password for security.**
* **You con't login to adminer without set environment `ADMINER_USER` and `ADMINER_PASSWD`.**

### Environment configuration

* `ADMINER_USER` : set the web basic user for Adminer.
* `ADMINER_PASSWD` : set the web basic password for Adminer.
* `--add-host` : If can't send mail, try to add the smtp server domain and IP.

### Upgrade Ranzhi version

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
Please visit your Ranzhi website to complete the upgrade task.
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
