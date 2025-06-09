#!/bin/bash

echo "🔧 替換 ossec.conf 裡的 MANAGER_IP..."
sed -i "s/MANAGER_IP/monitoring-server/" /var/ossec/etc/ossec.conf

echo "📄 替換後的 ossec.conf (前 20 行)："
head -n 20 /var/ossec/etc/ossec.conf

echo "🚀 啟動 Wazuh Agent..."
exec /var/ossec/bin/wazuh-agentd -f
