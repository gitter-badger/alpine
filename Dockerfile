FROM alpine:3.2
RUN apk add --update openssh-client bash && rm -rf /var/cache/apk/*

RUN echo 'root:root' |chpasswd
RUN /usr/bin/ssh-keygen -t rsa -b 2048 -f /ssh_rsa_key -N ""

EXPOSE 2222
ENTRYPOINT ["/usr/bin/ssh", "-i", "/ssh_rsa_key", "-T", "-N", "-o", "StrictHostKeyChecking=false", "-o", "ServerAliveInterval=180", "-L"]
