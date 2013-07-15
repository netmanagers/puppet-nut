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
    let(:expected) do
"ACL nut::upsd 127.0.0.1
ACCEPT nut::upsd
"
    end
    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsd_nut::upsd').with_target('/etc/nut/upsd.conf').with_content(expected) }
  end

  describe 'Test upsd.conf is created with name' do
    let(:params) do
      {
        :aclname => 'sample2',
      }
    end
    let(:expected) do
"ACL sample2 127.0.0.1
ACCEPT sample2
"
    end
    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsd_sample2').with_target('/etc/nut/upsd.conf').with_content(expected) }
  end

  describe 'Test upsd.conf is created with all main options' do
    let(:params) do
      {
        :aclname => 'somesubnet',
        :client  => '10.20.10.0/24',
        :action  => 'ACCEPT',
      }
    end
    let(:expected) do
"ACL somesubnet 10.20.10.0/24
ACCEPT somesubnet
"
    end

    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsd_somesubnet').with_target('/etc/nut/upsd.conf').with_content(expected) }
  end
end
