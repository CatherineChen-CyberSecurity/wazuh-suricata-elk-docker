#!/bin/bash

echo "Restarting Suricata container..."
docker restart suricata

echo "Suricata container restarted at $(date)"