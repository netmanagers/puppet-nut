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

end

