FROM centos:8

RUN yum install -y epel-release && \
	yum install -y openvpn unzip net-tools iptables && \
	mkdir /pia && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn-strong-tcp.zip" -o /strong.zip && \
	unzip -q /strong.zip -d /pia/strong && \
	rm -f /strong.zip && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn-tcp.zip" -o /normal.zip && \
	unzip -q /normal.zip -d /pia/normal && \
	rm -f /normal.zip && \
	yum remove -y epel-release unzip && \
	yum clean all && \
	groupadd -r vpn

COPY openvpn.sh /bin/openvpn.sh
WORKDIR /pia

ENV REGION="us_east"
ENV CONNECTIONSTRENGTH="strong"
ENTRYPOINT ["openvpn.sh"]
