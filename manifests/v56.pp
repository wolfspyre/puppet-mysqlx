# == Class: mysqlx::v56
#
# Full description of class mysqlx here.
#
# === Parameters
# [*add_repo*]  - Boolean which determines if this module is responbile for
#   creating the yumrepo
#
# [*enable_java*] - Boolean which includes the java-mysql class when true
#
# [*enable_php*] - Boolean which includes the php-mysql class when true
#
# [*enable_python*] - Boolean which includes the python-mysql class when true
#
# [*enable_ruby*] - Boolean which includes the ruby-mysql class when true
#
# [*repo_hash*] - A hash to feed create_resources to realize the yum repository
#
# [*server*]    - A boolean to determine if we should include the server class
#
# === Variables
#
# === Examples
#
#  This class is a namespace provider wrapper which also realizes the yumrepo
#  for the version in question, and purges 'mysql' packages as they're now a
#  dependency for common packages in rh variants, and may already be installed
#
# === Authors
#
# Wolf Noble <wnoble@datapipe.com>
#
# === Copyright
#
# Copyright 2013 Datapipe, unless otherwise noted.
#
class mysqlx::v56(
  $add_repo              = true,
  $basedir               = undef,
  $bind_address          = undef,
  $client_package_name   = undef,
  $config_file           = undef,
  $config_template       = undef,
  $datadir               = undef,
  $default_engine        = undef,
  $etc_root_password     = undef,
  $enable_java           = false,
  $enable_php            = false,
  $enable_python         = false,
  $enable_ruby           = false,
  $java_package_name     = undef,
  $log_error             = undef,
  $manage_service        = undef,
  $old_root_password     = undef,
  $package_name          = undef,
  $package_ensure        = undef,
  $php_package_name      = undef,
  $pidfile               = undef,
  $port                  = undef,
  $purge_conf_dir        = undef,
  $python_package_name   = undef,
  $repo_hash             = {'mysql56' => {
    descr      => 'MySQL 5.6',
    mirrorlist => 'http://rhnproxy.smq.datapipe.net/vendor/mysql/$releasever/$basearch/5.6/mirrorlist',
    gpgcheck   => '0' }},
  $restart               = undef,
  $root_group            = undef,
  $root_password         = undef,
  $ruby_package_name     = undef,
  $ruby_package_provider = undef,
  $server                = false,
  $server_package_name   = undef,
  $service_name          = undef,
  $service_provider      = undef,
  $socket                = undef,
  $ssl                   = undef,
  $ssl_ca                = undef,
  $ssl_cert              = undef,
  $ssl_key               = undef
  ){
  #invoke mysql class with our overrides
  $mysql_params = {
    basedir               => $basedir,
    bind_address          => $bind_address,
    client_package_name   => $client_package_name,
    config_file           => $config_file,
    config_template       => $config_template,
    datadir               => $datadir,
    default_engine        => $default_engine,
    etc_root_password     => $etc_root_password,
    java_package_name     => $java_package_name,
    log_error             => $log_error,
    manage_service        => $manage_service,
    old_root_password     => $old_root_password,
    package_ensure        => $package_ensure,
    php_package_name      => $php_package_name,
    pidfile               => $pidfile,
    port                  => $port,
    purge_conf_dir        => $purge_conf_dir,
    python_package_name   => $python_package_name,
    restart               => $restart,
    root_group            => $root_group,
    root_password         => $root_password,
    ruby_package_name     => $ruby_package_name,
    ruby_package_provider => $ruby_package_provider,
    server_package_name   => $server_package_name,
    service_name          => $service_name,
    socket                => $socket,
    ssl                   => $ssl,
    ssl_ca                => $ssl_ca,
    ssl_cert              => $ssl_cert,
    ssl_key               => $ssl_key,
  }
  validate_bool($enable_java)
  validate_bool($enable_php)
  validate_bool($enable_python)
  validate_bool($enable_ruby)
  create_resources('class', {'mysql' => $mysql_params})
  include mysql::params
  if $server {
    include mysql::server
  }
  if $enable_java {
    include mysql::java
  }
  if $enable_php {
    include mysql::php
  }
  if $enable_python {
    include mysql::python
  }
  if $enable_ruby {
    include mysql::ruby
  }
  #take advantage of the Anchor pattern
  anchor{'mysqlx::v56::begin':
    before => Anchor['mysqlx::v56::end'],
  }
  anchor {'mysqlx::v56::end':}
  case $::osfamily {
    RedHat: {
      #crufty exec hack to remove mysql packages due to dependencies.
      exec { 'remove_vanilla_mysql_packages':
        before    => Class['mysql'],
        creates   => "${datadir}/vanilla_packages_removed",
        command   => "/bin/bash -c 'for package in `/bin/rpm -qa|/bin/grep ^mysql`;do rpm -e \${package} --nodeps;done&&touch ${datadir}/vanilla_packages_removed'",
        logoutput => true,
        require   => File[$datadir]
      }
      #we only add the yumrepo for rhel variants
      if $add_repo {
        ##NOTE: This might work better
        #include dpcore
        #include dprepo
        #Exec['yum_clean_metadata'] -> Class['mysql']
        #Anchor['dprepo::end'] -> Class['mysql']
        #if $server {
        #  Exec['yum_clean_metadata'] -> Package['mysql-server']
        #}
        exec { 'mysqlx_yum_clean_metadata':
          command     => '/usr/bin/yum clean metadata',
          refreshonly => true,
          before      => Class['mysql'],
        }#end metadata cleaning exec
        Yumrepo {
          notify  => Exec['yum_clean_metadata'],
          before  => [Anchor['mysqlx::v56::end'],File[$datadir]],
        }
        create_resources('yumrepo', $repo_hash)
        $mysql_reponame = keys($repo_hash)
        mysqlx::add_repo_file{ $mysql_reponame: }
      }
    }
    default: {}
  }
}
