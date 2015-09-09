FROM alpine:3.2
RUN apk add --update openssh-client bash && rm -rf /var/cache/apk/*
VOLUME ["/ssh-agent"]
EXPOSE 2222
ENTRYPOINT ["/usr/bin/ssh", "-T", "-N", "-o", "StrictHostKeyChecking=false", "-o", "ServerAliveInterval=180", "-L"]
