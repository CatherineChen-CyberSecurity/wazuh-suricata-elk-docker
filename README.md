# wazuh-suricata-elk-docker
Purpose: This repository contains the Dockerized deployment setup for Wazuh, Suricata, and Kibana, used to simulate a network environment and generate security alerts.

# Docker-Based SOC Cybersecurity Lab

This project sets up a simulated Security Operations Center (SOC) environment using Docker. It integrates Wazuh, Suricata, Kali Linux, and more, making it suitable for cybersecurity training, attack detection, and threat analysis.

---

## Architecture Overview

| Container Name      | Role                  | Installed Tools                                                                 |
|---------------------|-----------------------|----------------------------------------------------------------------------------|
| `monitoring-server` | SOC Monitor       | Wazuh Manager + Elasticsearch + Kibana (log analysis and visualization)         |
| `victim-server`     | Attack Target       | Ubuntu + Wazuh Agent (log collection + attack simulation)                        |
| `attacker-server`   | Attacker Simulator  | Kali Linux + Nmap + Metasploit + Scapy (launch attacks on victim-server)        |
| `suricata`          | IDS (Detection)     | Suricata (analyze traffic and generate alerts for Wazuh)                        |

---

## Setup & Deployment

### Install Docker and Docker Compose

First, ensure Docker and Docker Compose are installed (recommended: Docker ≥ 20.x, Compose ≥ 2.x):

Install on Ubuntu:
```bash
sudo apt update
sudo apt install docker.io docker-compose
```
---

# Clone and Start the Environment
```bash
git clone https://github.com/CatherineChen-CyberSecurity/wazuh-suricata-elk-docker.git
cd wazuh-suricata-elk-docker
docker compose up -d

cd wazuh-server
docker compose up -d
```

---

# Services
Access Wazuh Dashboard: http://localhost:5601

The attacker and victim containers can communicate over the internal Docker network.

---

# Key Tools
Wazuh: A powerful open-source SIEM for log collection, analysis, and alerting.

Elasticsearch + Kibana: For storing and visualizing logs.

Suricata: High-performance IDS/IPS that detects malicious network activity.

Kali Linux: Penetration testing distribution including tools like Metasploit, Nmap, and Scapy.





