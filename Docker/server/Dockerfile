# Specify the parent image from which we build
FROM ubuntu:21.10

COPY hello.c nginx.conf Makefile ./

RUN apt-get update && apt-get upgrade -y\
    && apt-get install -y nginx\
    spawn-fcgi\
    make\
    gcc\
    nano\
    libfcgi-dev\
    && cp nginx.conf /etc/nginx/nginx.conf\
    && rm -rf /var/lib/apt/lists/*\
    && make
#     && adduser cangelen sudo
#     && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# USER cangelen
# WORKDIR /home/cangelen
 
CMD  spawn-fcgi -p 8080 hello.fcgi && nginx && tail -f /dev/null

# Part 4:
# docker build . -t hello_ubuntu:21.10
# //  no cp: docker run -p 80:81 -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf -t hello_ubuntu:21.10
# docker run -p 80:81 -t hello_ubuntu:21.10
