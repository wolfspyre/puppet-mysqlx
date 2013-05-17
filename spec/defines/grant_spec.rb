require 'spec_helper'

describe 'mysqlx::grant', :type => :define do
  let :title do
    'test_grant'
  end
  let (:params) {
    {  'user'     => 'testuser',
       'database' => 'testdb',
       'grant'    => 'testprivs',
       'host'     => 'testhost',
    }
  }
  it 'should report an error when ensure us not present or absent' do
    params.merge!({'ensure' => 'invalid_val'})
    expect { subject }.to raise_error(Puppet::Error,
      /invalid_val is not supported for ensure\. Allowed values are 'present' and 'absent'\./)
  end
  it { should contain_database_grant('testuser@testhost/testdb').with(
    'privileges' => 'testprivs',
    'require'       => 'Database_user[testuser@testhost]') }
end
