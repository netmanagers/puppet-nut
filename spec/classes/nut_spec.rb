require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nut' do

  let(:title) { 'nut' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42', :concat_basedir => '/var/lib/puppet/concat'} }

  describe 'Test include nut::client' do
    it { should include_class('nut::client') }
  end

  describe 'Test include nut::server' do
    let(:params) { {:install_mode => 'server' } }
    it { should include_class('nut::server') }
  end

  describe 'Test not include nut::server' do
    let(:params) { {:install_mode => 'client' } }
    it { should_not include_class('nut::server') }
  end

#  describe 'Test decommissioning - absent' do
#    let(:params) { {:absent => true} }
#    it 'should remove Package[nut-client]' do should contain_package('nut-client').with_ensure('absent') end
#    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
#    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#  end

#  describe 'Test decommissioning - disable' do
#    let(:params) { {:disable => true, :monitor => true} }
#    it { should contain_package('nut-client').with_ensure('present') }
#    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
#    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
#  end

#  describe 'Test decommissioning - disableboot' do
#    let(:params) { {:disableboot => true, :monitor => true } }
#    it { should contain_package('nut-client').with_ensure('present') }
#    it { should_not contain_service('ups').with_ensure('present') }
#    it { should_not contain_service('ups').with_ensure('absent') }
#    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
#  end

#  describe 'Test noops mode' do
#    let(:params) { {:noops => true, :monitor => true} }
#    it { should contain_package('nut-client').with_noop('true') }
#    it { should contain_service('ups').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#  end

#  describe 'Test decommissioning server - absent' do
#    let(:params) { {:absent => true, :install_mode => 'server'} }
#    let(:facts) { {  :operatingsystem => 'Debian' } }
#    it 'should remove Package[nut-server]' do should contain_package('nut-server').with_ensure('absent') end
#    it 'should stop Service[nut-server]' do should contain_service('nut-server').with_ensure('stopped') end
#    it 'should not enable at boot Service[nut-server]' do should contain_service('nut-server').with_enable('false') end
#  end

#  describe 'Test decommissioning server - absent' do
#    let(:params) { {:absent => true, :install_mode => 'server'} }
#    let(:facts) { {  :operatingsystem => 'Centos' } }
#    it 'should remove Package[nut]' do should contain_package('nut').with_ensure('absent') end
#    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
#    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#  end

#  describe 'Test decommissioning server - disable' do
#    let(:params) { {:disable => true, :monitor => true, :install_mode => 'server'} }
#    let(:facts) { {  :operatingsystem => 'Debian' } }
#    it { should contain_package('nut-server').with_ensure('present') }
#    it 'should stop Service[nut-server]' do should contain_service('nut-server').with_ensure('stopped') end
#    it 'should not enable at boot Service[nut-server]' do should contain_service('nut-server').with_enable('false') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
#  end

#  describe 'Test decommissioning server - disable' do
#    let(:params) { {:disable => true, :monitor => true, :install_mode => 'server'} }
#    let(:facts) { {  :operatingsystem => 'Centos' } }
#    it { should contain_package('nut').with_ensure('present') }
#    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
#    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
#  end


end

