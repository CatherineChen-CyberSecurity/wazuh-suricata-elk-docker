FROM ubuntu:22.04

# ENV Setting
ENV DEBIAN_FRONTEND=noninteractive

# Install plugin and Suricata
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl gnupg2 ca-certificates lsb-release \
    python3 python3-pip \
    suricata \
    && apt-get clean

# copy Suricata Setting（optional）
COPY suricata.yaml /etc/suricata/suricata.yaml

# Create the work directory
WORKDIR /etc/suricata

# Start Suricata instruction
CMD ["suricata", "-i", "enp0s3", "-c", "/etc/suricata/suricata.yaml", "-v"]
