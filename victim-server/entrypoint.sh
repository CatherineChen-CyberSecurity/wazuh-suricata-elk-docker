#!/bin/bash

WAZUH_MANAGER_IP="172.21.0.4"

echo "WAZUH_MANAGER_IP is: $WAZUH_MANAGER_IP"

echo "Replace ossec.conf's MANAGER_IP with ${WAZUH_MANAGER_IP}..."
sed -i "s/MANAGER_IP/${WAZUH_MANAGER_IP}/" /var/ossec/etc/ossec.conf

echo "Replaced ossec.conf："
head -n 20 /var/ossec/etc/ossec.conf

echo "Start agent-auth..."
/var/ossec/bin/agent-auth -m ${WAZUH_MANAGER_IP} -p 1515

echo "Start Wazuh Agent..."
exec /var/ossec/bin/wazuh-agentd -f
