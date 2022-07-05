FROM alpine:latest
RUN apk update
RUN apk add zabbix-agent
RUN sed -i 's/ServerActive=127\.0\.0\.1/ServerActive=192\.168\.1\.1/g' /etc/zabbix/zabbix_agentd.conf 
RUN sed -i 's/# HostMetadataItem=/HostMetadataItem=release/g' /etc/zabbix/zabbix_agentd.conf 
RUN sed -i '/Hostname=/s/^/#/g' /etc/zabbix/zabbix_agentd.conf
RUN sed -i '/HostnameItem/s/^# //g' /etc/zabbix/zabbix_agentd.conf
RUN echo "UserParameter=release,awk -F= '\$1==\"ID\" { print \$2 ;}' /etc/os-release" >> /etc/zabbix/zabbix_agentd.conf
CMD ["/usr/sbin/zabbix_agentd", "--foreground", "-c", "/etc/zabbix/zabbix_agentd.conf"]
