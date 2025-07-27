BRIDGE_IF := $(shell ip -o link show | awk -F': ' '{print $$2}' | grep '^br-' | head -n 1)
HOST_IF := $(shell ip -o -4 addr show | awk '!/docker|br-|veth|127.0.0.1/ {print $$2}' | head -n 1)

deploy:
	@echo "Running setup.sh to ensure Docker is installed..."
	@if ! command -v docker >/dev/null 2>&1; then \
		chmod +x setup.sh; ./setup.sh; \
	else \
		echo "Docker already installed, skipping setup.sh"; \
	fi

	@echo "Docker Bridge Interface: $(BRIDGE_IF)"
	@echo "Host Interface: $(HOST_IF)"

	@if [ -f ./suricata/suricata.yaml.template ]; then \
		sed "s/{interface}/$(BRIDGE_IF)/g" ./suricata/suricata.yaml.template > ./suricata/suricata.yaml; \
	else \
		echo "Template ./suricata/suricata.yaml.template not found!"; exit 1; \
	fi

	@if [ -f docker-compose.yml.template ]; then \
		sed "s/{interface}/$(BRIDGE_IF),$(HOST_IF)/g" docker-compose.yml.template > docker-compose.yml; \
	else \
		echo "Template docker-compose.yml.template not found!"; exit 1; \
	fi

	@docker compose up -d
	@cd wazuh-server && docker compose up -d

up:
	@docker compose up -d
	@cd wazuh-server && docker compose up -d

down:
	@docker compose down
	@cd wazuh-server && docker compose down

clean:
	@docker compose down -v
	@cd wazuh-server && docker compose down -v