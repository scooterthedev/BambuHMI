#!/bin/sh
### BEGIN INIT INFO
# Provides:          webhmi
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts the webhmi service
# Description:       Runs the little_webhmi.py Python script as a service at boot.
### END INIT INFO

# Using the Python interpreter from a specific location:
DAEMON_PATH="/opt/python/bin/"

# Script to be executed:
DAEMON="python3 /opt/python/bin/little_webhmi.py"

# Script name:
NAME="webhmi"

# Run levels:
PIDFILE="/var/run/$NAME.pid"

case "$1" in
  start)
    echo "Starting $NAME..."
    start-stop-daemon --start --pidfile $PIDFILE --make-pidfile --exec $DAEMON_PATH$DAEMON --background
    ;;
  stop)
    echo "Stopping $NAME..."
    start-stop-daemon --stop --pidfile $PIDFILE
    if [ -e $PIDFILE ]
      then rm $PIDFILE
    fi
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
    echo "Usage: /etc/init.d/$NAME {start|stop|restart}"
    exit 1
esac

exit 0
