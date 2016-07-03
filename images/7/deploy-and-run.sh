#!/bin/sh

DIR=${DEPLOY_DIR:-/deployments}
echo "Checking *.war in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.war; do
     file=$(basename $i)
     echo "Linking $i --> /opt/jetty/webapps/$file"
     ln -s $i /opt/jetty/webapps/$file
  done
fi

export JAVA_OPTIONS="$JAVA_OPTIONS $(/opt/run-java-options) $(/opt/jetty/bin/java-container-options) -Djava.security.egd=file:/dev/./urandom"
/usr/bin/env bash /opt/jetty/bin/jetty.sh run
