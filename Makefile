FIG=docker-compose
BACKUP_DIR=`pwd`/backup

.PHONY: build backup

build:
	@$(FIG) build

up:
	@$(FIG) up -d

down:
	@$(FIG) down

start:
	@$(FIG) start

stop:
	@$(FIG) stop

restart: stop start

update: down build up

backup:
ifneq ($(shell id -u), 0)
	@echo "please run as superuser"
	@exit 1
endif
	@$(FIG) stop
	@if [ ! -d $(BACKUP_DIR) ]; then \
		mkdir -p $(BACKUP_DIR); \
		echo 'create dir $(BACKUP_DIR)'; \
	fi
	tar czf $(BACKUP_DIR)/lxrng-`date "+%Y%m%d"`.tar.gz cache db repo text-db
	@$(FIG) start

