#!/bin/bash
# wrapper to run entrance with env vars

export XDG_RUNTIME_DIR="/tmp/ecore"

for d in "${XDG_RUNTIME_DIR}"{,/.ecore} /usr/share/xsessions; do
	[[ ! -d "${d}" ]] && mkdir -p "${d}"
done

echo "[Desktop Entry]
Name=XSession
Comment=Xsession
Exec=/etc/entrance/Xsession
TryExec=/etc/entrance/Xsession
Icon=
Type=Application
" > /usr/share/xsessions/Xsession.desktop

sed -i -e "s|nobody|travis|" /etc/entrance/entrance.conf

/usr/sbin/entrance

EPID="$(pgrep entrance)"

#kill -SIGUSR1 ${EPID}

SLEEP=180

echo "${0} Going to sleep for ${SLEEP}"
sleep ${SLEEP}
echo "${0} Waking up"

ps xa o pid,user,group,command
echo ""

ls -la /tmp
echo ""

kill ${EPID}

#killall entrance_client

#EPID="$(pgrep X)"

#[[ ${EPID} ]] && kill -9 ${EPID}

ps xa o pid,user,group,command

#systemctl start entrance
