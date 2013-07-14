require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'nut::upsconcat' do

  let(:title) { 'nut::upsconcat' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) do
    {
      :ipaddress       => '10.42.42.42',
      :operatingsystem => 'Debian',
      :concat_basedir  => '/var/lib/puppet/concat'
    }
  end

  describe 'Test ups.conf is created with no options' do
    let(:params) do
      {
        :name => 'sample1',
      }
    end
    let(:expected) do
"# This file is managed by Puppet. DO NOT EDIT.
[sample1]
  driver = usbhid-ups
  port = auto

"
    end

    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsconcat_sample1').with_target('/etc/nut/ups.conf').with_content(expected) }
  end

  describe 'Test ups.conf is created with all main options' do
    let(:params) do
      {
        :name            => 'sample2',
        :ups_name        => 'someups',
        :ups_port        => 'ttyS0',
        :ups_driver      => 'somedriver',
        :ups_description => 'Test Config',
      }
    end
    let(:expected) do
"# This file is managed by Puppet. DO NOT EDIT.
[sample2]
  desc = "Test Config"
  driver = usbhid-ups
  port = auto

"
    end

    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_upsconcat_sample2').with_target('/etc/nut/ups.conf').with_content(expected) }
  end
end
