require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'nut::upsd' do

  let(:title) { 'nut::upsd' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) do
    {
      :ipaddress       => '10.42.42.42',
      :operatingsystem => 'Debian',
      :concat_basedir  => '/var/lib/puppet/concat'
    }
  end

  describe 'Test upsd.conf is created with no options' do
    let(:params) do
      {
        :name => 'sample1',
      }
    end
    let(:expected) do
"# This file is managed by Puppet. DO NOT EDIT.
LISTEN 127.0.0.1
ACL all 0.0.0.0/0
ACL localhost 127.0.0.1/8
ACCEPT localhost
REJECT all
"
    end

    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsd_sample1').with_target('/etc/nut/upsd.conf').with_content(expected) }
  end

  describe 'Test upsd.conf is created with all main options' do
    let(:params) do
      {
        :name    => 'sample2',
        :aclname => 'somesubnet',
        :client  => '10.20.10.0/24',
        :action  => 'ACCEPT',
      }
    end
    let(:expected) do
"# This file is managed by Puppet. DO NOT EDIT.
LISTEN 127.0.0.1
LISTEN 10.20.10.20
ACL all 0.0.0.0/0
ACL somesubnet 10.20.10.0/24
ACL localhost 127.0.0.1/8
ACCEPT localhost
ACCEPT somesubnet
REJECT all
"
    end

    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsd_sample2').with_target('/etc/nut/upsd.conf').with_content(expected) }
  end
end
