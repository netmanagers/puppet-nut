require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nut::server' do

  let(:title) { 'nut::server' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' , :concat_basedir => '/var/lib/puppet/concat'} }

  describe 'Test standard Centos installation' do
    let(:facts) { {  :operatingsystem => 'Centos', :install_mode => 'server' , :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut').with_ensure('present') }
    it { should contain_service('ups').with_ensure('running') }
    it { should contain_service('ups').with_enable('true') }
  end

  describe 'Test standard Debian installation' do
    let(:facts) { { :operatingsystem => 'Debian', :install_mode => 'server', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut-server').with_ensure('present') }
    it { should contain_service('nut-server').with_ensure('running') }
    it { should contain_service('nut-server').with_enable('true') }
  end

  describe 'Test decommissioning Centos server - absent' do
    let(:facts) { {  :operatingsystem => 'Centos', :install_mode => 'server', :nut_absent => true, :monitor => true , :concat_basedir => '/var/lib/puppet/concat'} }
    it 'should remove Package[nut]' do should contain_package('nut').with_ensure('absent') end
    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it 'should remove nut configuration file' do should contain_file('nut.conf').with_ensure('absent') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
  end

  describe 'Test decommissioning Debian server - absent' do
    let(:facts) { {  :operatingsystem => 'Debian', :install_mode => 'server', :nut_absent => true, :monitor => true , :concat_basedir => '/var/lib/puppet/concat'} }
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
#    it { should contain_monitor__process('nut_process').with_enable('false') }
  end

  describe 'Test decommissioning Centos server - disable' do
    let(:facts) { {:nut_disable => true, :monitor => true, :install_mode => 'server', :operatingsystem => 'Centos', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut').with_ensure('present') }
    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
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
    let(:facts) { {:nut_noops => true, :monitor => true , :firewall => true, :port => '3493', :protocol => 'tcp', :operatingsystem => 'Centos', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut').with_noop('true') }
#    it { should contain_service('nut').with_noop('true') }
#    it { should contain_file('nut.conf').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#    it { should contain_monitor__port('nut_tcp_3493').with_noop('true') }
#    it { should contain_firewall('nut_tcp_3493').with_noop('true') }
  end

  describe 'Test noops mode Debian server' do
    let(:facts) { {:nut_noops => true, :monitor => true , :firewall => true, :port => '3493', :protocol => 'tcp', :operatingsystem => 'Debian', :concat_basedir => '/var/lib/puppet/concat'} }
    it { should contain_package('nut-server').with_noop('true') }
#    it { should contain_service('nut').with_noop('true') }
#    it { should contain_file('nut.conf').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#    it { should contain_monitor__port('nut_tcp_3493').with_noop('true') }
#    it { should contain_firewall('nut_tcp_3493').with_noop('true') }
  end

## VIEJO

#  describe 'Test customizations - template' do
#    let(:params) { {:template => "nut/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
#    it 'should generate a valid template' do
#      content = catalogue.resource('file', 'nut.conf').send(:parameters)[:content]
#      content.should match "fqdn: rspec.example42.com"
#    end
#    it 'should generate a template that uses custom options' do
#      content = catalogue.resource('file', 'nut.conf').send(:parameters)[:content]
#      content.should match "value_a"
#    end
#  end

#  describe 'Test customizations - source' do
#    let(:params) { {:source => "puppet:///modules/nut/spec"} }
#    it { should contain_file('nut.conf').with_source('puppet:///modules/nut/spec') }
#  end

#  describe 'Test customizations - source_dir' do
#    let(:params) { {:source_dir => "puppet:///modules/nut/dir/spec" , :source_dir_purge => true } }
#    it { should contain_file('nut.dir').with_source('puppet:///modules/nut/dir/spec') }
#    it { should contain_file('nut.dir').with_purge('true') }
#    it { should contain_file('nut.dir').with_force('true') }
#  end

#  describe 'Test customizations - custom class' do
#    let(:params) { {:my_class => "nut::spec" } }
#    it { should contain_file('nut.conf').with_content(/rspec.example42.com/) }
#  end

#  describe 'Test service autorestart' do
#    let(:params) { {:service_autorestart => "no" } }
#    it 'should not automatically restart the service, when service_autorestart => false' do
#      content = catalogue.resource('file', 'nut.conf').send(:parameters)[:notify]
#      content.should be_nil
#    end
#  end

#  describe 'Test Puppi Integration' do
#    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }
#    it { should contain_puppi__ze('nut').with_helper('myhelper') }
#  end

#  describe 'Test Monitoring Tools Integration' do
#    let(:params) { {:monitor => true, :monitor_tool => "puppi" } }
#    it { should contain_monitor__process('nut_process').with_tool('puppi') }
#  end

#  describe 'Test Firewall Tools Integration' do
#    let(:params) { {:firewall => true, :firewall_tool => "iptables" , :protocol => "tcp" , :port => "3493" } }
#    it { should contain_firewall('nut_tcp_3493').with_tool('iptables') }
#  end

#  describe 'Test OldGen Module Set Integration' do
#    let(:params) { {:monitor => "yes" , :monitor_tool => "puppi" , :firewall => "yes" , :firewall_tool => "iptables" , :puppi => "yes" , :port => "3493" , :protocol => 'tcp' } }
#    it { should contain_monitor__process('nut_process').with_tool('puppi') }
#    it { should contain_firewall('nut_tcp_3493').with_tool('iptables') }
#    it { should contain_puppi__ze('nut').with_ensure('present') }
#  end

#  describe 'Test params lookup' do
#    let(:facts) { { :monitor => true , :ipaddress => '10.42.42.42' } }
#    let(:params) { { :port => '3493' } }
#    it 'should honour top scope global vars' do should contain_monitor__process('nut_process').with_enable('true') end
#  end

#  describe 'Test params lookup' do
#    let(:facts) { { :nut_monitor => true , :ipaddress => '10.42.42.42' } }
#    let(:params) { { :port => '3493' } }
#    it 'should honour module specific vars' do should contain_monitor__process('nut_process').with_enable('true') end
#  end

#  describe 'Test params lookup' do
#    let(:facts) { { :monitor => false , :nut_monitor => true , :ipaddress => '10.42.42.42' } }
#    let(:params) { { :port => '3493' } }
#    it 'should honour top scope module specific over global vars' do should contain_monitor__process('nut_process').with_enable('true') end
#  end

# describe 'Test params lookup' do
#   let(:facts) { { :monitor => false , :ipaddress => '10.42.42.42' } }
#   let(:params) { { :monitor => true , :firewall => true, :port => '3493' } }
#   it 'should honour passed params over global vars' do should contain_monitor__process('nut_process').with_enable('true') end
# end

end

