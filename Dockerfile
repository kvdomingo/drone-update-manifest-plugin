FROM alpine/git

ARG YQ_VERSION=v4.2.0
ARG YQ_BINARY=yq_linux_amd64

RUN wget "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz" -O - | tar xz && \
    mv "${YQ_BINARY}" /usr/bin/yq && \
    mkdir -p /root/.ssh && \
    touch /root/.ssh/config && \
    touch /root/.ssh/known_hosts

ADD main.sh /bin/

RUN chmod +x /bin/main.sh

ENTRYPOINT /bin/main.sh
