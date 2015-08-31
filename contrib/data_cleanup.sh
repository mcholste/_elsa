#!/bin/sh

DATA_DIR="/data"
# Include local config
if [ -f /etc/elsa_vars.sh ]; then
	. /etc/elsa_vars.sh
fi
############
# Clean up
############
cleanup(){
     echo "Dropping ELSA data.."
     echo "" > $DATA_DIR/elsa/log/node.log
     mysqladmin -f drop syslog
     mysqladmin -f drop syslog_data
     sh /usr/local/elsa/contrib/install.sh node set_node_mysql
     /usr/local/sphinx/bin/indexer --config /usr/local/etc/sphinx.conf --rotate --all
     service syslog-ng stop
     service searchd stop
     rm -rf $DATA_DIR/elsa/tmp/buffers/*
     rm -rf $DATA_DIR/sphinx/*
     service searchd start
     service syslog-ng start 
}

# Double-check files to delete.
delcheck() {
  echo "You are about to cleanup all ELSA data files. This can not be undone."
  read -p 'Continue with the clean up? [y/N] ' doit
  case "$doit" in
    [yY])        
        cleanup;;
        echo "ELSA data files deleted."
    *) echo "User Aborted";;
  esac
}

delcheck


