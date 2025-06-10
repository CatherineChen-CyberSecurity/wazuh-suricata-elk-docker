#!/bin/bash

WAZUH_MANAGER_IP="172.21.0.3"

echo "Replace ossec.conf's MANAGER_IP with ${WAZUH_MANAGER_IP}..."
sed -i "s/MANAGER_IP/${WAZUH_MANAGER_IP}/" /var/ossec/etc/ossec.conf

echo "Replaced ossec.conf："
head -n 20 /var/ossec/etc/ossec.conf

echo "Start Wazuh Agent..."
exec /var/ossec/bin/wazuh-agentd -f
