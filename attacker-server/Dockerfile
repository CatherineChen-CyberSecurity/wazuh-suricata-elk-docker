FROM kalilinux/kali-rolling

RUN apt-get update && apt-get install -y metasploit-framework nmap python3-pip python3-venv

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --upgrade pip
RUN pip install scapy

CMD ["/bin/bash"]
