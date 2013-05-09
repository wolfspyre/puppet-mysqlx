#!/usr/bin/env rspec
require 'spec_helper'
describe 'mysqlx::v55', :type => :class do
  describe 'On a RedHat OS' do
    let :facts do { :osfamily => 'RedHat' } end
    let (:default_params) do
      {
        :add_repo              => true,
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
        :repo_hash             => {'mysql55' => {
          'descr'      => 'MySQL 5.5',
          'mirrorlist' => 'http://rhnproxy.smq.datapipe.net/vendor/mysql/$releasever/$basearch/5.5/mirrorlist',
          'gpgcheck'   => '0'}
          },
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
      default_params.merge({ :add_repo => false })
    end
    ['mysql','mysql::params','mysqlx::v55'].each do |myclass|
      it { should contain_class(myclass) }
    end
    context 'When add_repo is false' do
      it {should_not contain_yumrepo('mysql55')}
    end
    context 'When add_repo is true' do
      let :params do
        default_params.merge({ :add_repo => true })
      end
      it {should contain_yumrepo('mysql55')}
      it {should contain_file('yumrepo_mysql55')}
       #it { p subject.resources }
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
