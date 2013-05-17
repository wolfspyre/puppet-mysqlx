#mysqlx

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with mysqlx](#setup)
    * [What mysqlx affects](#what-mysqlx-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with mysqlx](#beginning-with-mysqlx)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module is a helper module designed to harness the puppetlabs-mysql module for our needs. It adds namespacing for each version of mysql (5, 5.5, 5.6) so that sane default values can be placed in hiera without conflict

##Module Description

This module facilitates us feeding the puppetlabs-mysql module.

##Setup

###What mysqlx affects

* MySQL 5.6 support is currently broken
* With the notable exception of a yumrepo and a file resource on 5.5/5.6, this module doesn't *really* impact things directly. All the heavy lifting is done through the mysql module

###Setup Requirements **OPTIONAL**

If your module requires anything before setting up (pluginsync enabled, etc.) this is where you mention it.

###Beginning with mysqlx

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

##Usage

Classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module.

##Reference

There are three namespacing classes:
  - v5
    * This supports mysql5 on rh5 and 5.1 on rh6
  - v55
    * This supports MySQL 5.5 on rh5/6 and adds a custom yum repository with packages downloaded from Oracle.
  - v56
    * This supports MySQL 5.6 on rh5/6 and adds a custom yum repository with packages downlaoded from Oracle

There are two defined types:
  - *mysqlx::grant* : is fed a user, database, grant, and a host. it feeds them to the database_grant resource provided by mysql
  - *mysqlx::user* : is fed a password, database, and a host. it feeds them to the database_user resource provided by mysql

There is one helper class:
  - *mysqlx::minion* : This expects a hash of databases fed to it via the databases parameter, a hash of grants fed to it via the grant parameter, and a hash of users fed to it via the user parameter. It will subsequently feed those hashes to the aforementioned defined types via create_resources.

##Limitations

Tested on rh5/6. Support for other OSes is limited/nonexistent at this time.
MySQL 5.6 does not work yet.

##Development

Guidelines and instructions for contributing to your module.

##Release Notes/Contributors/Etc **Optional**

5/17/13 - Added grant, minion, and user
