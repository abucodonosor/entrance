#!/bin/bash
# wrapper to run entrance with env vars

export XDG_RUNTIME_DIR="/run/user/0"

for d in "${XDG_RUNTIME_DIR}"{,/.ecore/efreetd} /usr/share/xsessions; do
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

/usr/sbin/entrance

EPID=$(pgrep entrance)

kill -SIGUSR1 ${EPID}

sleep 3

kill ${EPID}
kill $(pgrep entrance_client)

#systemctl start entrance