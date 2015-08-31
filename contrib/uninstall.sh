#!/bin/sh

DATA_DIR="/data"
# Include local config
if [ -f /etc/elsa_vars.sh ]; then
	. /etc/elsa_vars.sh
fi
###########
# Stop Services
###########

APACHE="apache2"
if [ -f /etc/redhat-release ] || [ -f /etc/fedora-release ] || [ -f /etc/system-release ]; then
  APACHE="httpd"
fi

stop_services(){  
    echo "Stopping services.."
    service searchd stop 
    service syslog-ng stop
    service $APACHE stop
    service starman stop
    killall perl 
}

############
# Clean up
############
cleanup(){
     echo "Dropping ELSA data.."
     #drop databases
	 mysqladmin -f drop elsa_web
	 mysqladmin -f drop syslog
	 mysqladmin -f drop syslog_data

	 #Remove folders
	 echo "Deleting ELSA directories.."
	 rm -rf $DATA_DIR/elsa
	 rm -rf $DATA_DIR/sphinx
	 rm -rf /etc/elsa*
	 rm -rf /usr/local/elsa
	 rm -rf /usr/local/syslog-ng
}

# Double-check files to delete.
delcheck() {
  echo "You are about to delete all ELSA related files and data. This process can not be undone."
  read -p 'Continue with the un-installation? [y/N] ' doit
  case "$doit" in
    [yY]) 
        stop_services
        cleanup;;
        echo "ELSA data and files deleted."
    *) echo "User Aborted.";;
  esac
}

delcheck