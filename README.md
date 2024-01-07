Makefile has to build the docker images
using docker-compose.yml

# subject inspection/comprehension
## what is docker-compose.yml?
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application's services. Then, with a single command, you create and start all the services from your configuration. [source](https://docs.docker.com/compose/#:~:text=Compose%20is%20a%20tool%20for,to%20configure%20your%20application's%20services.)

## how to install a virtual machine? 
[ubuntu doc on virtualbox](https://doc.ubuntu-fr.org/virtualbox)

## [What is a Dockerfile?](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#what-is-a-dockerfile)

Docker builds images automatically by reading the instructions from a Dockerfile which is a text file that contains all commands, in order, needed to build a given image.
Dockerfile is a text document that contains commands to assemble an image. Docker can then build an image by reading those instructions.

## what is Docker Compose?
Il s’agit d’un **outil de ligne de commande**, similaire au client Docker, utilisant un fichier de description spécifiquement formaté pour assembler les applications à partir de conteneurs multiples et de les exécuter sur un hôte unique. [source](https://datascientest.com/docker-guide-complet)

## what is a docker image?
Une image Docker est **un modèle en lecture seule**, utiliser pour créer des conteneurs Docker. Elle est composée de plusieurs couches empaquetant toutes les installations, dépendances, bibliothèques, processus et codes d’application nécessaires pour un environnement de conteneur pleinement opérationnel. [source](https://datascientest.com/docker-guide-complet)

## what is a docker container?
It is a running instance of an image. A container is a way to package application with all the necessary dependencies and configuration. It is a portable artifact, easily shared and moved around. It makes development and deployment more efficient.
Technically, it is made of layers of images. At the base of most containers, we have a linux base image, and it is important that it is small in size, thus alpine.

## what is the (docker) service?
also called the docker engine. It's the main part of the docker that makes the virtualization. It is a server with a long-running doaemon process "dockerd". It manages images & containers.k

## other definitions
"penultimate stable version of Alpine or Debian"? = l'avant derniere version de debian ou alpine

## instructions
write Dockerfiles, one per service
Dockerfiles must be called in your docker-compose.yml by your Makefile. It means you have to build yourself the Docker images of your project. 

It is then forbidden to pull ready-made Docker images, as well as using services such as DockerHub
(Alpine/Debian being excluded from this rule).

## what is NGINX, TLSv1.2 TLSv1.3?
read [How To Configure Nginx to use TLS 1.2 / 1.3 only](https://www.cyberciti.biz/faq/configure-nginx-to-use-only-tls-1-2-and-1-3/)
  
TLS is an acronym for Transport Layer Security.
wordpress
php-fpm
mariaDB
## what is a volume?
It allows us to have persistent data.

## what is a docker-network?
Docker creates its isolated Docker network where the containers are running in.


## PID 1?
[PID 1 medium, Boutnaru](https://medium.com/@boutnaru/the-linux-process-journey-pid-1-init-60765a069f17)
 Mostly known as “init”. init is the first Linux user-mode process created, which runs until the system shuts down. init manages the services (called demons under Linux, more on them in a future post). Also, if we check the process tree of a Linux machine we will find that the root of the tree is init.
 There are multiple implementation of init. Ubuntu 22.04 uses systemd.
## what are the best practices for writing Dockerfiles?

https://docs.docker.com/develop/develop-images/guidelines/

https://sysdig.com/blog/dockerfile-best-practices/

https://developers.redhat.com/articles/2023/03/23/10-tips-writing-secure-maintainable-dockerfiles

Selecting a specific version of a Docker image
# Notes for [Docker Crash Course for Absolute Beginners [NEW]](https://www.youtube.com/watch?v=pg19Z8LL06w) and [Docker Tutorial for Beginners [FULL COURSE in 3 Hours]](https://www.youtube.com/watch?v=3c-iBn73dDE)

## VM vs Docker
An OS kernel is the middle man between the hardware and the applications.
Docker virtualizes the OS applications layer, it uses the kernel of the host.
A VM virtualizes a complete system (the kernel + the applications layer).
Applications run on the kernel layer.
They are both virtualization tools.

That means that docker images are much smaller than VM images.
Containers take seconds to start while VMs take minutes.
But docker is only compatible with linux distros.
Docker Desktop allows you to run Linux containers on Windows or MacOS.


## Where are Docker images?
We get the docker images in the **docker registries**. It's a storage and distribution system for Docker images. Official images are maintained by the software authors or in collaboration with the Docker community. Docker hosts one of the biggest Docker Registry, called Docker Hub.

### Registry or repository
A Docker Registry is a service providing storage, it is a collection of repositories.
A Docker Repository is a collection of related images with the same name but different versions.

Docker Hub is a registry, you can host private or public repositories on it for your applications.

Companies create custom images for their applications.

## How to run containers
Pull an image to download locally:
docker pull nginx:1.23

Docker Hub is the default registry.

Run a Docker image:
docker run nginx:1.23

Running a Docker image that is not already in your computer, pull that Docker image and run it.

### About ports
Port binding = bind the container's port to the host's port to make the service availble to the outside world.
The container runs in some port. Each application has a standard port on which its running.
nginx port 80
redis port 6379
mySQL port 3306

docker run -d -p 9000:80 nginx:1.23

-d in detached mode.
-p 9000:80 exposes the container to our local network, or localhost, to be able to access our application that is inside the container.

Only 1 service can run on a specific port on the host. So e.g. only 1 service can run on port 9000.
It's a standard to use the same port on your host as the container is using.

### Basic commands
docker run creates a new container every time, it doesn't re-use the previous container. 

docker ps -a 
to see all running and stopped containers.

To run the previous container:
docker start <container_id>

or

docker start <container_name>

To override the auto-generated container_name:
docker run --name <container_name> -d -p 8080:80 nginx:1.23

Delete tous les containers, et leurs volumes:
docker rm -vf $(docker ps -aq)

Delete all images
docker rmi -f $(docker images -aq)

## How can I create my own Docker image for MY use-case application?
By writing a Dockerfile.

Dockerfiles start from a parent image or "base image". with the "FROM" keyword.

### Structure of Dockerfile:
FROM -> build this image from the specified image.

RUN -> will execute any command in a shell **inside** the container environment. (to install dependencies)

COPY -> copies files or directories from <src> and adds them to the filesystem of the container at the path <dest>

WORKDIR -> sets the working directory (similarly to "cd <path>" in command line)

CMD -> the instruction that is to be executed when a Dcoker container starts. There can only be one "CMD" instruction in a Dockerfile. E.g. node server.js for the case of a nodejs application.


Once written, we can build the image with:
docker build -t <image_name>:<tag> <dockerfile_location>
(the tag is like the version of MY image)

Once built, we can run it.

## Developing with containers

By default, docker provides some networks,
docker network ls

Create our own network,
docker network create <network_name>

Docker run options,
-e to overwrite the default env variables
--net to specify the network

## Running multiple services
Docker compose.yaml is a structured file that contains very normal docker commands. It takes care of the task of creating a common network between containers that need to talk to each other. So that, the --net option for docker run is not needed.
The indentation needs to be correct!

Start containers using docker compose,
docker-compose -f <file.yaml> up

### Docker Volumes
#### When do we need Docker Volumes?
A container runs in a host, the container has a virtual filesystem. Without volumes, when restarting or removing the container, we lose the data.


The host file system is mounted on the virtual file system. Data gets automatically replicated.

3 volumes types:
- docker run -v <host_filesystem_path>
- docker run -v <container_filesystem_path>
For each container, a folder is generated that gets mounted. They are called anonymous volumes.
- docker run -v <volume_name>:<container_filesystem_path>
They are called named volumes. You can reference this volume and it should be used in production.

# My run
I created all project files and directories.
Wrote a Makefile by following:
https://write.vanoix.com/emeric/makefile-et-docker-en-dev
https://antho.dev/le-makefile-cest-magique/
Followed this youtube tutorial on Docker Compose: [Docker Compose will BLOW your MIND (a tutarial)](https://www.youtube.com/watch?v=DM65_JyGxCo) while tyring to adapt it to my case. I didn't work. I had this error msg on localhost:port "Error establishing a database connection". 
I saw that WordPress uses MySQL as its database, maybe using MariaDB was what caused the error.
J'ai copié-collé un fichier docker-compose utilisant wordpress et mysql sans essayer de l'adapter. Et localhost donna un autre message d'erreur, avec Firefox, SSL_ERROR_RX_RECORD_TOO_LONG . 
Je devais retirer le 's' de https pour accéder a localhost. BINGO, ca a marché, je suis bien tombé sur la page d'accueil de wordpress.

Maintenant, je dois adapter ca a mon cas, cad avec mariadb. Mais d'abord quelle est la différence entre mysql et mariadb ?
MariaDB est un fork de MySQL.
Les développeurs de MariaDB s’assurent que chaque version est compatible avec la version correspondante de MySQL. MariaDB adopte non seulement les fichiers de définition des données et des tables de MySQL, mais utilise également des protocoles clients, des APIs clients, des ports et des sockets identiques. L’objectif est de permettre aux utilisateurs de MySQL de passer à MariaDB sans problème.
[source](https://www.hostinger.fr/tutoriels/mariadb-vs-mysql)

Oops ! D'apres divers tutoriels trouvés sur github, je devais commencer a creer une image nginx en premier.

Dans ma VM linux,

sudo service stop mariadb
sudo service stop apache2
sudo service stop mysql

sudo systemctl stop nginx
sudo service stop nginx
Sinon, http://localhost me donne la page d'accueil de nginx deja installé sur mon OS et je peux pas afficher mon nginx a moi.

Ecrire le Dockerfile et le nginx.conf.
Tuto suivi :
Dans le directory nginx,
docker build -t myimagenginx .
docker run --name mon_container_nginx -p 127.0.0.1:443:443/tcp myimagenginx -d