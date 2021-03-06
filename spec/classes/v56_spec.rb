#!/usr/bin/env rspec
require 'spec_helper'
describe 'mysqlx::v56', :type => :class do
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
        :repo_hash             => {'mysql56' => {
          'descr'      => 'MySQL 5.6',
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
    ['enable_java', 'enable_php','enable_python','enable_ruby'].each do |enable_extra|
      it "should report an error when #{enable_extra} is not a boolean" do
        params.merge!({ enable_extra => 'BOGON'})
        expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not a boolean.  It looks to be a String/)
      end
    end
    ['mysql','mysql::params','mysqlx::v56'].each do |myclass|
      it { should contain_class(myclass) }
    end
    context 'When add_repo is false' do
      it {should_not contain_yumrepo('mysql56')}
    end
    context 'When add_repo is true' do
      let :params do
        default_params.merge({ :add_repo => true })
      end
      it {should contain_yumrepo('mysql56')}
      it {should contain_file('yumrepo_mysql56')}
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
    context 'when enable_java is true' do
      let :params do
        default_params.merge({ :enable_java => true})
      end
      it {should contain_class('mysql::java')}
    end
    context 'when enable_php is true' do
      let :params do
        default_params.merge({ :enable_php => true})
      end
      it {should contain_class('mysql::php')}
    end
    context 'when enable_python is true' do
      let :params do
        default_params.merge({ :enable_python => true})
      end
      it {should contain_class('mysql::python')}
    end
    context 'when enable_ruby is true' do
      let :params do
        default_params.merge({ :enable_ruby => true})
      end
      it {should contain_class('mysql::ruby')}
    end
  end
end
