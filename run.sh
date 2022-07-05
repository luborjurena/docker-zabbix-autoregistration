#/bin/bash
if which docker >/dev/null; then
    CONTAINERS=docker
elif which podman >/dev/null; then
    CONTAINERS=podman
else
    echo "No provider was found."
    exit
fi

$CONTAINERS image rm zabbix-autoregistration
$CONTAINERS build -t zabbix-autoregistration .
$CONTAINERS run --hostname=zbx-`echo $RANDOM` -it -d zabbix-autoregistration
