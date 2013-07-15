require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nut::nutconf' do

  let(:title) { 'nut::nutconf' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test nut.conf config untouched when empty start_mode' do
    let(:facts) { {:nut_install_mode => 'client' } }
    it { should_not contain_file('nut.conf') }
  end

  describe 'Test nut.conf when start_mode has value in Debian' do
    let(:facts) do
      {
        :operatingsystem  => 'Debian',
        :nut_start_mode   => 'standalone',
      } 
    end
    it { should contain_file('nut_conf').with_content("# This file is managed by Puppet. DO NOT EDIT.\nMODE=standalone\n") }
  end

  describe 'Test nut.conf when start_mode has value in CentOS' do
    let(:facts) do
      {
        :operatingsystem  => 'CentOS',
        :nut_start_mode   => 'standalone',
      } 
    end
    let(:expected) do
"# This file is managed by Puppet. DO NOT EDIT.
# If the UPS is locally attached set it to \"yes\"
SERVER=yes
# Any options to pass to upsd
UPSD_OPTIONS=
# This *must* be the same as in /etc/ups/upsmon.conf
POWERDOWNFLAG=/etc/killpower
#
# [End]
"
    end
    it { should contain_file('nut_conf').with_content(expected) }
  end

  describe 'Test noops mode' do
    let(:facts) { {:nut_noops => true, :monitor => true} }
    it { should contain_file('nut_conf').with_noop('true') }
  end

end

