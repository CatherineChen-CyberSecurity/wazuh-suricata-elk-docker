# wazuh-suricata-elk-docker
Purpose: This repository contains the Dockerized deployment setup for Wazuh, Suricata, and Kibana, used to simulate a network environment and generate security alerts.

# Docker-Based SOC Cybersecurity Lab

This project sets up a simulated Security Operations Center (SOC) environment using Docker. It integrates Wazuh, Suricata, Kali Linux, and more, making it suitable for cybersecurity training, attack detection, and threat analysis.

---

## Architecture Overview

| Container Name      | Role                  | Installed Tools                                                                 |
|---------------------|-----------------------|----------------------------------------------------------------------------------|
| `wazuh-server-wazuh.manager-1` | SOC Monitor       | Wazuh Manager + Elasticsearch + Kibana (log analysis and visualization)         |
| `victim-server`     | Attack Target       | Ubuntu + Wazuh Agent (log collection + attack simulation)                        |
| `attacker-server`   | Attacker Simulator  | Kali Linux + Nmap + Metasploit + Scapy (launch attacks on victim-server)        |
| `suricata`          | IDS (Detection)     | Suricata (analyze traffic and generate alerts for Wazuh)                        |

---

# Clone and Start the Environment
```bash
git clone https://github.com/CatherineChen-CyberSecurity/wazuh-suricata-elk-docker.git
cd wazuh-suricata-elk-docker
```
---
## Setup & Deployment

### Install Docker and Docker Compose

First, ensure Docker and Docker Compose are installed (recommended: Docker ≥ 20.x, Compose ≥ 2.x):

Install make
```bash
sudo apt update
sudo apt install -y make
```
### Set up .env
#### Kindly copy env_template, rename it to .env, and place it in the wazuh-server folder.

### Using Makefile to Deploy and Manage the Environment
This project provides a Makefile to simplify the setup, startup, shutdown, and cleanup of the Docker containers. Make sure you have Docker, Docker Compose, and make installed on your system.

1. Setup Environment (Install Docker and Create Docker Network)
```bash
sudo make setup
```
- Installs Docker via setup.sh if not already installed.
- Checks if the Docker network monitoring-net exists; creates it if missing.

2. Deploy the Full Environment
```bash
sudo make deploy
```
This command will:

- Set the system parameter vm.max_map_count=262144 required by Wazuh Indexer.
- Automatically detect the Docker Bridge and Host network interfaces.
- Generate the Suricata configuration file (suricata.yaml) and docker-compose.yml with the correct interfaces.
- Generate Wazuh certificates using Docker Compose.
- Start all necessary containers (Wazuh Manager, Indexer, Dashboard, Suricata, attacker, and victim servers).

3. Start Containers
```bash
make up
```
Starts the Docker Compose containers in detached mode.

4. Stop Containers
```bash
make down
```

5. Clean Up Environment
```bash
make clean
```
Stops and removes containers and associated Docker volumes — useful for a full reset.

---

# Services
Access Wazuh Dashboard: https://localhost/app/wz-home

The attacker and victim containers can communicate over the internal Docker bridge network (monitoring-net).

---

# Key Tools
Wazuh: A powerful open-source SIEM for log collection, analysis, and alerting.

Elasticsearch + Kibana: For storing and visualizing logs.

Suricata: High-performance IDS/IPS that detects malicious network activity.

Kali Linux: Penetration testing distribution including tools like Metasploit, Nmap, and Scapy.

---
## Documentation
- [Operation Manual (PDF)](docs/Operation_Manual.pdf)




