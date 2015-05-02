FROM busybox:latest


ADD https://github.com/upfluence/etcdenv/releases/download/v0.1.2/etcdenv-linux-amd64-0.1.2 /usr/bin/etcdenv
ADD https://github.com/upfluence/uchiwa/releases/download/v0.8.2/uchiwa-linux-amd64 /uchiwa
ADD https://github.com/upfluence/uchiwa/releases/download/v0.8.2/public.zip /public.zip

RUN chmod +x /usr/bin/etcdenv
RUN chmod +x /uchiwa
RUN unzip public.zip -d . && rm public.zip

EXPOSE 3000

ENV UCHIWA_PORT 3000
ENV SENSU_NAMESPACE /environments/sensu

CMD  etcdenv -n $SENSU_NAMESPACE -s http://172.17.42.1:4001 /uchiwa -p /public
