#!/usr/bin/env rspec
require 'spec_helper'
describe 'mysqlx::minion', :type => :class do
  describe 'On a RedHat OS' do
    let :facts do { :osfamily => 'RedHat' } end
    let (:params) do
      {
        'databases' => {
          'foo_db' => {
            'ensure'   => 'present',
            'user'     => 'foo_db_user',
            'password' => 'some-test-password',
            'host'     => 'localhost'
          }},
        'grants'    => {
          'granttest_dbuser' => {
            'ensure'   => 'present',
            'user'     => 'granttest',
            'database' => 'somedatabase',
            'grant'    => 'all',
            'host'     => '%'
          }},
        'users'     => {
          'usertest' => {
            'ensure'   => 'present',
            'database' => 'database',
            'password' => 'somepassword',
            'host'     => '%'
          }},
      }
    end
    ['databases', 'grants','users'].each do |resources|
      it "should report an error when #{resources} is not a hash" do
        params.merge!({ resources => 'BOGON'})
        expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not a Hash.  It looks to be a String/)
      end
    end
    #      it {p subject.resources}
    context 'when the databases hash is set' do
      it { should contain_database('foo_db')}
      it { should contain_database_user('foo_db_user@localhost').with('password_hash' => '*315722F1BCC6C6FE07EE74D74E5F6F417F709AF3')}
      it { should contain_database_grant('foo_db_user@localhost/foo_db')}

    end
    context 'when the grants hash is set' do
      it {should contain_database_grant('granttest@%/somedatabase')}
    end
    context 'when the users hash is set' do
      it {should contain_database_user('usertest@%')}
    end

    context 'when the databases hash is empty' do
      it do
        params.merge!({ 'databases' => false })
        should_not contain_database('foo_db')
      end
    end
    context 'when the grants hash is empty' do
      it do
        params.merge!({ 'grants' => false })
        should_not contain_database_grant('granttest@%/somedatabase')
      end
    end
    context 'when the users hash is empty' do
      it do
        params.merge!({ 'users' => false })
        should_not contain_database_user('usertest@%')
      end
    end
  end
end
