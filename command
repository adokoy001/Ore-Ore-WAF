#!/bin/sh
case $1 in
    production)
	plenv exec starman --workers 50 --max-requests 200 --port=5002 --daemonize --pid=starman.pid -preload-app -a psgi_server.pl
	;;
    develop)
	plenv exec plackup psgi_server.pl
	;;
    stop)
	cat starman.pid | xargs kill && echo "Starman stop success." || echo "Starman stop failed(already stopped)"
	;;
    *)
	echo "please select startup option below:";
	echo "production, develop, stop";
	;;
esac
