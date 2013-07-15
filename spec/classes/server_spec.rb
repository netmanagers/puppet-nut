require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nut::server' do

  let(:title) { 'nut::server' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) do
    { 
      :ipaddress => '10.42.42.42',
      :concat_basedir => '/var/lib/puppet/concat'
    }
  end

  describe 'Test standard Centos installation' do
    let(:facts) do
      {  
        :operatingsystem => 'Centos',
        :install_mode => 'server',
        :concat_basedir => '/var/lib/puppet/concat'
      }
    end
    it { should contain_package('nut').with_ensure('present') }
    it { should contain_service('ups').with_ensure('running') }
    it { should contain_service('ups').with_enable('true') }
  end

  describe 'Test standard Debian installation' do
    let(:facts) do
      {  
        :operatingsystem => 'Debian',
        :install_mode => 'server',
        :concat_basedir => '/var/lib/puppet/concat'
      }
    end
    it { should contain_package('nut-server').with_ensure('present') }
    it { should contain_service('nut-server').with_ensure('running') }
    it { should contain_service('nut-server').with_enable('true') }
  end

  describe 'Test decommissioning Centos server - absent' do
    let(:facts) do
      {  
        :operatingsystem => 'Centos',
        :install_mode => 'server',
        :nut_absent => true,
        :monitor => true ,
        :concat_basedir => '/var/lib/puppet/concat'
      }
    end
    it 'should remove Package[nut]' do should contain_package('nut').with_ensure('absent') end
    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it 'should remove nut configuration file' do should contain_file('nut.conf').with_ensure('absent') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
  end

  describe 'Test decommissioning Debian server - absent' do
    let(:facts) do
      { 
        :operatingsystem => 'Debian',
        :install_mode => 'server',
        :nut_absent => true,
        :monitor => true ,
        :concat_basedir => '/var/lib/puppet/concat'
      }
    end
    it 'should remove Package[nut-server]' do should contain_package('nut-server').with_ensure('absent') end
    it 'should stop Service[nut-server]' do should contain_service('nut-server').with_ensure('stopped') end
    it 'should not enable at boot Service[nut-server]' do should contain_service('nut-server').with_enable('false') end
#    it 'should remove nut configuration file' do should contain_file('nut.conf').with_ensure('absent') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
  end

  describe 'Test decommissioning Debian  server - disable' do
    let(:facts) { {:nut_disable => true, :monitor => true, :install_mode => 'server', :operatingsystem => 'Debian', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut-server').with_ensure('present') }
    it 'should stop Service[nut-server]' do should contain_service('nut-server').with_ensure('stopped') end
    it 'should not enable at boot Service[nut-server]' do should contain_service('nut-server').with_enable('false') end
  end

  describe 'Test decommissioning Centos server - disable' do
    let(:facts) { {:nut_disable => true, :monitor => true, :install_mode => 'server', :operatingsystem => 'Centos', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut').with_ensure('present') }
    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
  end

  describe 'Test decommissioning Debian server - disableboot' do
    let(:facts) { {:nut_disableboot => true, :monitor => true , :firewall => true, :port => '3493', :protocol => 'tcp', :operatingsystem => 'Debian', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut-server').with_ensure('present') }
    it { should_not contain_service('nut-server').with_ensure('present') }
    it { should_not contain_service('nut-server').with_ensure('absent') }
    it 'should not enable at boot Service[nut-server]' do should contain_service('nut-server').with_enable('false') end
    it { should contain_firewall('nut_tcp_3493').with_enable('true') }
  end

  describe 'Test noops mode Centos server' do
    let(:facts) do
      { 
        :nut_noops => true,
        :monitor => true ,
        :firewall => true,
        :port => '3493',
        :protocol => 'tcp',
        :operatingsystem => 'Centos',
        :concat_basedir => '/var/lib/puppet/concat'
      }
    end
    it { should contain_package('nut').with_noop('true') }
    it { should contain_service('ups').with_noop('true') }
    it { should contain_monitor__process('nut_server_process').with_noop('true') }
    it { should contain_firewall('nut_tcp_3493').with_noop('true') }
  end

  describe 'Test noops mode Debian server' do
    let(:facts) do
      { 
        :nut_noops => true,
        :monitor => true ,
        :firewall => true,
        :port => '3493',
        :protocol => 'tcp',
        :operatingsystem => 'Debian',
        :concat_basedir => '/var/lib/puppet/concat'
      }
    end
    it { should contain_package('nut-server').with_noop('true') }
    it { should contain_service('nut-server').with_noop('true') }
    it { should contain_monitor__process('nut_server_process').with_noop('true') }
    it { should contain_firewall('nut_tcp_3493').with_noop('true') }
  end

#  describe 'Test service autorestart' do
#    let(:params) { {:service_autorestart => "no" } }
#    it 'should not automatically restart the service, when service_autorestart => false' do
#      content = catalogue.resource('file', 'nut.conf').send(:parameters)[:notify]
#      content.should be_nil
#    end
#  end

end

