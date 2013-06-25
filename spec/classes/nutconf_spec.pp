require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'nut::nutconf' do

  let(:title) { 'nut::nutconf' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test nut.conf config untouched when empty start_mode' do
    let(:facts) { {:install_mode => 'client' } }
    it { should_not contain_file('nut.conf') }
  end

  describe 'Test nut.conf set when start_mode has value' do
    let(:facts) { {:install_mode => 'nutconf',
                   :start_mode = 'standalone' } 
                }
    it { should contain_file('nut_conf').with_content("# This file is managed by Puppet. DO NOT EDIT.\nMODE=standalone\n") }
  end

  describe 'Test noops mode' do
    let(:facts) { {:nut_noops => true, :monitor => true} }
    it { should contain_file('nut_conf').with_noop('true') }
  end

end

