FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install -y mariadb-server \
		 systemctl

# for debugging purpose
#RUN apt install -y tmux \
#        vim
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/mariadb_starter.sh /home/
RUN chmod +x /home/mariadb_starter.sh
ENTRYPOINT ["/home/mariadb_starter.sh"]
