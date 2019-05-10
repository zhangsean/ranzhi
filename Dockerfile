FROM buildpack-deps:18.04-curl

LABEL MAINTAINER="ZhangSean <zxf2342@qq.com>"

ARG RANZHI_VER=5.0

ARG RANZHI_URL=http://dl.cnezsoft.com/ranzhi/${RANZHI_VER}/ranzhi.${RANZHI_VER}.stable.int.zbox_64.tar.gz

RUN wget -c ${RANZHI_URL} -O /tmp/zbox.tar.gz

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN chmod +x /usr/local/bin/docker-entrypoint

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80

ENTRYPOINT ["docker-entrypoint"]
