FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install -y mariadb-server 

# for debugging purpose
#RUN apt install -y tmux \
#        vim

# config file for mariadb
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /home/
RUN chmod +x /home/setup.sh
CMD /bin/bash /home/setup.sh
