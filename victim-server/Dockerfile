FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic plugin and SSH
RUN apt update && apt install -y rsyslog openssh-server curl gnupg lsb-release

# create SSH related settings
RUN mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#LogLevel.*/LogLevel DEBUG/' /etc/ssh/sshd_config  && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Install Wazuh Agent
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
    apt-get update && \
    apt-get install -y wazuh-agent

# env and entrypoint
ARG MANAGER_IP
ENV MANAGER_IP=${MANAGER_IP}
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
