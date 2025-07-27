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

## Setup & Deployment

### Install Docker and Docker Compose

First, ensure Docker and Docker Compose are installed (recommended: Docker ≥ 20.x, Compose ≥ 2.x):

Install on Ubuntu:
```bash
# Run the setup script to install Docker
chmod +x setup.sh
./setup.sh

```
---

# Clone and Start the Environment
```bash
git clone https://github.com/CatherineChen-CyberSecurity/wazuh-suricata-elk-docker.git
cd wazuh-suricata-elk-docker

# only first time need to execute this command to make all containers connect with each other
docker network create --driver=bridge --subnet=172.21.0.0/16 monitoring-net

# !To ensure Suricata detects traffic properly, you must replace the interface name in suricata.yaml with your actual Docker bridge interface.
ip a # Get the actual Docker bridge interface and host vm interface
# Locate the interface section in ./suricata/suricata.yaml and docker-compose.yml by using the filter "# <-- Replace with your actual bridge interface and your host vm interface" to search
# Example
# ./suricata/suricata.yaml
af-packet:
  - interface: {}

pcap:
  - interface: {}

# docker-compose.yml 
suricata:
    image: 
    container_name: 
    privileged: 
    network_mode: 
    volumes:
    command: ["suricata", "-i", "{}"}, "-c", "/etc/suricata/suricata.yaml", "--init-errors-fatal"] # <-- Replace with your actual bridge interface and your host vm interface


cd wazuh-suricata-elk-docker
docker compose up -d

cd wazuh-server
docker compose up -d
```

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





