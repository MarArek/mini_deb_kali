# From light Debian image
FROM bitnami/minideb

USER root:root

# Update and apt install programs
RUN 	apt-get update && apt-get install -y gnupg2 && \
	apt-get upgrade -y && apt-get dist-upgrade -y
	
	apt-get install -y \
	 net-tools && iproute2 && iputils-ping \
	 git \
	 gdb \
	 hashcat \
	 hydra \
	 man-db \
	 nmap \
	 sqlmap \
	 sslscan \
	 xauth \
	 python-pip \
	 wget

#Install Kali repositories
RUN 	gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6 && \
	gpg -a --export ED444FF07D8D0BF6 | apt-key add - && \
	echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list && apt-get update -m

# Other installs
RUN pip install pwntools
# Update ENV
ENV PATH=$PATH:/opt/powersploit

#Set Xauthority path to pass GUI apps to host
RUN ln -s $XAUTHORITY ${HOME}/.Xauthority

# Set entrypoint and working directory
WORKDIR /root/

# Indicate we want to expose ports 80 and 443
EXPOSE 80/tcp 443/tcp

#Defaultly start with Bash
CMD [ "/bin/bash" ]
