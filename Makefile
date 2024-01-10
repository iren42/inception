COMPOSE_PROJECT_NAME := inception

DC_FILE := ./srcs/docker-compose.yml

DOCKER_COMPOSE	:= docker compose -f $(DC_FILE)


.PHONY: all
all:
	@echo "Launching containers from project $(COMPOSE_PROJECT_NAME)..."
	$(DOCKER_COMPOSE) up -d
	$(DOCKER_COMPOSE) ps

.PHONY: stop
stop:
	@echo "Stopping containers from project $(COMPOSE_PROJECT_NAME)..."
	$(DOCKER_COMPOSE) stop
	docker ps

# stop, discard containers, volumes and networks
.PHONY: down
down:
	@echo "Stop and discard containers, volumes, networks from project $(COMPOSE_PROJECT_NAME)..."
	$(DOCKER_COMPOSE) down --volumes
	$(DOCKER_COMPOSE) down --remove-orphans
	docker ps

.PHONY: logs
logs:
	$(DOCKER_COMPOSE) logs
	docker ps

.PHONY: clean
clean:
	docker stop $$(docker ps -qa)
	docker rm -fv $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network prune -f
#	docker network rm $$(docker network ls -q) # this one gives me lots of errors

.PHONY: prune
prune:
	docker system prune -af
