FROM alpine:3.2
RUN apk add --update openssh-client bash && rm -rf /var/cache/apk/*

# RUN echo 'root:root' |chpasswd
# VOLUME /.keys
# RUN /usr/bin/ssh-keygen -t rsa -b 2048 -f /ssh_rsa_key -N ""

RUN echo $'#!/bin/bash\n\
/usr/bin/ssh-keygen -q -t rsa -b 2048 -f /.keys/ssh_rsa_key -N ""\n\
cat /.keys/ssh_rsa_key.pub\n'\
>> /key_init
RUN chmod +x /key_init

EXPOSE 2222
ENTRYPOINT ["/usr/bin/ssh", "-i", "/.keys/ssh_rsa_key", "-T", "-N", "-o", "StrictHostKeyChecking=false", "-o", "ServerAliveInterval=180", "-L"]

# docker run --name keys -v /.keys busybox
# docker run -it --rm --entrypoint="/key_init" --volumes-from keys testt
