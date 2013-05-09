#!/usr/bin/env rspec
require 'spec_helper'
describe 'mysqlx::v5', :type => :class do
  describe 'On a RedHat OS' do
    let :facts do { :osfamily => 'RedHat' } end
    let (:default_params) do
      {
        :basedir               => '/usr',
        :bind_address          => '127.0.0.1',
        :client_package_name   => 'MySQL-client',
        :config_file           => '/etc/my.cnf',
        :datadir               => '/var/lib/mysql',
        :default_engine        => 'innodb',
        :etc_root_password     => false,
        :java_package_name     => 'mysql-connector-java',
        :log_error             => '/var/log/mysqld.log',
        :manage_service        => true,
        :package_ensure        => 'latest',
        :php_package_name      => 'php-mysql',
        :pidfile               => '/var/run/mysqld/mysqld.pid',
        :port                  => '3306',
        :purge_conf_dir        => true,
        :python_package_name   => 'MySQL-python',
        :restart               => false,
        :root_group            => 'root',
        :root_password         => 'mHDSo294442-jkdjsks-sws82mp',
        :ruby_package_name     => 'ruby-mysql',
        :ruby_package_provider => 'gem',
        :server                => false,
        :server_package_name   => 'MySQL-server',
        :service_name          => 'mysql',
        :socket                => '/var/lib/mysql/mysql.sock',
        :ssl                   => false,
        :ssl_ca                => '/etc/mysql/cacert.pem',
        :ssl_cert              => '/etc/mysql/server-cert.pem',
        :ssl_key               => '/etc/mysql/server-key.pem'
      }
    end
    let :params do
      default_params.merge({ :server => false })
    end
    ['mysql','mysql::params','mysqlx::v5'].each do |myclass|
      it { should contain_class(myclass) }
    end
    context 'when server is false' do
      it {should_not contain_class('mysql::server')}
    end
    context 'when server is true' do
      let :params do
        default_params.merge({ :server => true })
      end
      it {should contain_class('mysql::server')}
    end
  end
end
