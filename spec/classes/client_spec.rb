require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nut::client' do

  let(:title) { 'nut::client' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard installation' do
    it { should contain_package('nut-client').with_ensure('present') }
    it { should contain_service('ups').with_ensure('running') }
    it { should contain_service('ups').with_enable('true') }
  end

  describe 'Test ups.conf config adsent in client mode' do
    let(:facts) { {:install_mode => 'client' } }
    it { should_not contain_file('ups.conf') }
  end

  describe 'Test upsd.conf config adsent in client mode' do
    let(:facts) { {:install_mode => 'client' } }
    it { should_not contain_file('upsd.conf') }
  end

  describe 'Test upsd.user config adsent in client mode' do
    let(:facts) { {:install_mode => 'client' } }
    it { should_not contain_file('upsd.user') }
  end

  describe 'Test decommissioning - absent' do
    let(:facts) { {:nut_absent => true, :monitor => true} }
    it 'should remove Package[nut-client]' do should contain_package('nut-client').with_ensure('absent') end
    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
  end

  describe 'Test decommissioning - disable' do
    let(:facts) { {:nut_disable => true, :monitor => true} }
    it { should contain_package('nut-client').with_ensure('present') }
    it 'should stop Service[ups]' do should contain_service('ups').with_ensure('stopped') end
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
  end

  describe 'Test decommissioning - disableboot' do
    let(:facts) { {:nut_disableboot => true, :monitor => true } }
    it { should contain_package('nut-client').with_ensure('present') }
    it { should_not contain_service('ups').with_ensure('present') }
    it { should_not contain_service('ups').with_ensure('absent') }
    it 'should not enable at boot Service[ups]' do should contain_service('ups').with_enable('false') end
#    it { should contain_monitor__process('nut_process').with_enable('false') }
  end

  describe 'Test noops mode' do
    let(:facts) { {:nut_noops => true, :monitor => true} }
    it { should contain_package('nut-client').with_noop('true') }
    it { should contain_service('ups').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
#    it { should contain_monitor__process('nut_process').with_noop('true') }
  end


#  describe 'Test customizations - template' do
#    let(:params) { {:template => "nut/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
#    it 'should generate a valid template' do
#      content = catalogue.resource('file', 'upsmon.conf').send(:parameters)[:content]
#      content.should match "fqdn: rspec.example42.com"
#    end
#    it 'should generate a template that uses custom options' do
#      content = catalogue.resource('file', 'upsmon.conf').send(:parameters)[:content]
#      content.should match "value_a"
#    end
#  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "nut::spec" } }
  end

#  describe 'Test service autorestart' do
#    let(:params) { {:service_autorestart => "no" } }
#    it 'should not automatically restart the service, when service_autorestart => false' do
#      content = catalogue.resource('file', 'upsmon.conf').send(:parameters)[:notify]
#      content.should be_nil
#    end
#  end

  describe 'Test Puppi Integration' do
    let(:facts) { {:puppi => true, :puppi_helper => "myhelper"} }
    it { should contain_puppi__ze('nut').with_helper('myhelper') }
  end

#  describe 'Test Monitoring Tools Integration' do
#    let(:facts) { {:monitor => true, :monitor_tool => "puppi" } }
#    it { should contain_monitor__process('nut_process').with_tool('puppi') }
#  end

#  describe 'Test OldGen Module Set Integration' do
#    let(:params) { {:monitor => "yes" , :monitor_tool => "puppi" , :puppi => "yes"} }
#    it { should contain_monitor__process('nut_process').with_tool('puppi') }
#    it { should contain_puppi__ze('nut').with_ensure('present') }
#  end

end

