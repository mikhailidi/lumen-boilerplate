#!/bin/bash

function params(){
	echo "Pick an Option:"
	echo " - shell -- to get access to the shell"
	exit
}

if [ "$#" -eq 0 ]; then
	params
fi
case "$1" in
	shell)
		HOST=""
		if [ "$(uname)" != "Darwin" ]; then
			docker exec -t boilerplate-app /bin/bash -c "id -u host &>/dev/null || \
				addgroup -g $(id -u) host && id -u host &>/dev/null || \
				adduser -u $(id -g) -G host host -D; cp /root/.bashrc /home/host"
			$HOST="--user host"
		fi
		docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -ti $HOST boilerplate-app /bin/bash
		;;
	*)
		params
		;;
esac
