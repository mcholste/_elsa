ODE
===================
This forked branch is for Opallios distribution of ELSA, ODE. [ELSA](https://github.com/mcholste/elsa) is a log management and analytical system. Some of the key changes so far include, running Starman as the default http server, fixes in install script to be more reliable, adding http server watchdog. ODE 0.1 can be installed either as packages or image. Please refer to [opalliosode.org](http://www.opalliosode.org) for more details on ODE.

Getting Started
-------------
The latest release of ODE is, **ODE 0.1**. This first ODE release has been tested and verified on four different linux flavors using the standard packaging, deb and rpm.

### <i class="icon-file"></i> ODE Installation

**Note:** You may still use elsa_vars.sh under /etc directory before running the package to make any configuration changes as is the case with the original ELSA installation.

#### Debian - Ubuntu 12.04 and 14.04
> Download the package,
```
> wget https://s3-us-west-1.amazonaws.com/ode0.1/ode_0.1-2_all.deb
```
>  Run the package,
```
> sudo dpkg -i Downloads/ode_0.1-2_all.deb
> sudo apt-get install -f
```
**Note:** dpkg will complain of missing dependencies, ignore it.

#### RPM - RHEL 6.6 and Centos 6.5
> Download the package,
```
> wget https://s3-us-west-1.amazonaws.com/ode0.1/ode-0.1-2.noarch.rpm
```
>  Run the package,
```
> sudo yum install Downloads/ode-0.1-2.noarch.rpm
```

#### Verify Installation

> Check the log,
```
  > vi /var/log/ode_install.log
```
> Run web UI,
```
> http://<ip>
```

#### Removing Packages

In case you want to remove the installed package. Note, this will delete all the ode related data and configuration on your machine.

> Debian (ubuntu),
```
  > apt-get --purge autoremove ode
```
> RPM (RHEL/Centos),
```
> yum remove ode
```

### <i class="icon-file"></i> AWS Images

You may also use the pre-built ODE images (medium and large systems) on AWS for quick installation or evaluation. You can search for "opallios" in the Community AMIs for these images.

* Ubuntu 12.04 Med - ODE-ubuntu-1204-med-Opallios
* Ubuntu 14.04 Large - ODE-ubuntu-1404-large-Opallios
* RedHat 6.6 Med - ODE-rhel-66-med-Opallios

elsa
====

Enterprise Log Search and Archive (ELSA) is a three-tier log receiver, archiver, indexer, and web frontend for incoming syslog.  It leverages syslog-ng's pattern-db parser for efficient log normalization and Sphinx full-text indexing for log searching.  The logging backend scan be scaled to N nodes in a distributed system if a load balancer is placed in front of the incoming logs as a virtual IP address.  The normalization process assigns each incoming log a class ID which is used, in conjuction with the log sender host and program for the basis of permissions.  Users can be granted granular permissions for a given host, program, or class (or a combination therein).  The permissions are whitelists or full access for each of the permissions components.  That is, a user may be restricted to one or n given hosts but be able to query any program or class on those hosts.

ELSA is divided into three major components: the backend nodes, the middleware Perl daemon that runs on the web server, and the web site itself.  The backend nodes have no knowledge of the web frontend and respond to any requests to their listening port from the middleware.  The middleware is configured to point at any one of the nodes.  The queried node will delegate any subqueries to sister nodes transparently to the middleware.  The middleware, janus, will then asynchronously handle requests from Apache and proxy them to the backend nodes and ferry responses back to Apache.  Many queries can be running simultaneously as the whole system is asynchronous.

Queries can ask for the responses to be grouped by a given field, creating light-weight reporting with an accompanying graph.  

Authentication and authorization can be LDAP-based, but some configuration is required by the user to specify how the groups and search filters.

Sphinx is RAM-intensive, so occasionally, the system will consolidate indexes into a "permanent" form that does not consume any RAM.  The rate at which this consolidation can run at is the terminal sustained rate of the system (per node).  On a 4 CPU, 4 GB RAM system, this is typically around 6000 logs per second.  The system can burst well over 50,000 logs/second/node for long periods of time as long as it eventually has time to recover.
