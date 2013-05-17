require 'spec_helper'

describe 'mysqlx::user', :type => :define do
  let :title do
    'test_user'
  end
  let (:params) {
    {  'password' => 'testpass',
       'database' => 'testdb',
       'host'     => 'testhost',
    }
  }
  it 'should report an error when ensure us not present or absent' do
    params.merge!({'ensure' => 'invalid_val'})
    expect { subject }.to raise_error(Puppet::Error,
      /invalid_val is not supported for ensure\. Allowed values are 'present' and 'absent'\./)
  end
  it { should contain_database_user('test_user@testhost').with(
    'ensure'        => 'present',
    'password_hash' => '*00E247AC5F9AF26AE0194B41E1E769DEE1429A29',
    'require'       => 'Database[testdb]') }
end
