# == Class: mysqlx::55
#
# Full description of class mysqlx here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# This class shouldn't ever be invoked directly. It simply is a namespace
#
# === Authors
#
# Wolf Noble <wnoble@datapipe.com>
#
# === Copyright
#
# Copyright 2013 Datapipe, unless otherwise noted.
#
class mysqlx::55(
  $basedir               = $mysql::basedir,
  $bind_address          = $mysql::bind_address,
  $client_package_name   = $mysql::client_package_name,
  $config_file           = $mysql::config_file,
  $config_template       = $mysql::config_template,
  $datadir               = $mysql::datadir,
  $default_engine        = $mysql::default_engine,
  $etc_root_password     = $mysql::etc_root_password,
  $java_package_name     = $mysql::java_package_name,
  $log_error             = $mysql::log_error,
  $manage_service        = $mysql::manage_service,
  $old_root_password     = $mysql::old_root_password,
  $package_name          = $mysql::package_name,
  $package_ensure        = $mysql::package_ensure,
  $php_package_name      = $mysql::php_package_name,
  $pidfile               = $mysql::pidfile,
  $port                  = $mysql::port,
  $purge_conf_dir        = $mysql::purge_conf_dir,
  $restart               = $mysql::restart,
  $root_group            = $mysql::root_group,
  $root_password         = $mysql::root_password,
  $ruby_package_name     = $mysql::ruby_package_name,
  $ruby_package_provider = $mysql::ruby_package_provider,
  $server_package_name   = $mysql::server_package_name,
  $service_name          = $mysql::service_name,
  $service_provider      = $mysql::service_provider,
  $socket                = $mysql::socket,
  $ssl                   = $mysql::ssl,
  $ssl_ca                = $mysql::ssl_ca,
  $ssl_cert              = $mysql::ssl_cert,
  $ssl_key               = $mysql::ssl_key
  )inherits mysql {

}
