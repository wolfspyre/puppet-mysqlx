# == Class: mysqlx::5
#
# Full description of class mysqlx here.
#
# === Parameters
#
# [*server*] - a boolean to determine if we should include the server class
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
class mysqlx::v5(
  $basedir               = undef,
  $bind_address          = undef,
  $client_package_name   = undef,
  $config_file           = undef,
  $config_template       = undef,
  $datadir               = undef,
  $default_engine        = undef,
  $etc_root_password     = undef,
  $java_package_name     = undef,
  $log_error             = undef,
  $manage_service        = undef,
  $old_root_password     = undef,
  $package_ensure        = undef,
  $php_package_name      = undef,
  $pidfile               = undef,
  $port                  = undef,
  $purge_conf_dir        = undef,
  $python_package_name   = undef,
  $restart               = undef,
  $root_group            = undef,
  $root_password         = undef,
  $ruby_package_name     = undef,
  $ruby_package_provider = undef,
  $server                = false,
  $server_package_name   = undef,
  $service_name          = undef,
  $socket                = undef,
  $ssl                   = undef,
  $ssl_ca                = undef,
  $ssl_cert              = undef,
  $ssl_key               = undef
  ){
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
  create_resources('class', {'mysql' => $mysql_params})
  include mysql::params
  if $server {
    include mysql::server
  }
}
