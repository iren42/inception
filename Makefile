COMPOSE_PROJECT_NAME := inception

DC_FILE := ./srcs/docker-compose.yml

DOCKER_COMPOSE	:= docker compose -f $(DC_FILE)


.PHONY: all
all:
	$(DOCKER_COMPOSE) build --no-cache
#	$(DOCKER_COMPOSE) run --no-deps --rm wordpress 
	@echo "Launching containers from project $(COMPOSE_PROJECT_NAME)..."
	$(DOCKER_COMPOSE) up -d
	$(DOCKER_COMPOSE) ps

.PHONY: stop
stop:
	@echo "Stopping containers from project $(COMPOSE_PROJECT_NAME)..."
	$(DOCKER_COMPOSE) stop
	docker ps

.PHONY: down
down:
	$(DOCKER_COMPOSE) down
	docker ps

.PHONY: prune
prune:
	$(DOCKER_COMPOSE) down --remove-orphans
	$(DOCKER_COMPOSE) down --volumes
	$(DOCKER_COMPOSE) rm -f
