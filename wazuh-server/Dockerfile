FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl apt-transport-https lsb-release gnupg

# Add Wazuh Repository GPG key
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - \
    && echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list

# Install Wazuh Manager
RUN apt-get update && apt-get install -y wazuh-manager

# Start Wazuh Manager，and keep it run
CMD ["/var/ossec/bin/ossec-control", "start", "-f"]
