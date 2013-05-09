require 'spec_helper'

describe 'mysqlx::add_repo_file', :type => :define do
  let :title do
    'test_repofile'
  end
  it { should contain_file("yumrepo_#{title}").with(
    'group' => 'root',
    'mode'  => '0644',
    'owner' => 'root',
    'path'  => "/etc/yum.repos.d/#{title}.repo") }
end