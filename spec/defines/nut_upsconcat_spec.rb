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
    let(:expected_ups_conf_fragment) do
"[sample1]
  desc = \"Local UPS\"
  driver = usbhid-ups
  port = auto
"
    end
    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_add_ups_sample1').with_target('/etc/nut/ups.conf').with_content(expected_ups_conf_fragment) }
  end

  describe 'Test ups.conf is created with all main options' do
    let(:params) do
      {
        :name            => 'sample2',
        :ups_name        => 'someups',
        :ups_port        => 'ttyS0',
        :ups_vendorid    => '0xid',
        :ups_productid   => '0xpd',
        :ups_offdelay    => '20',
        :ups_ondelay     => '10',
        :ups_pollfreq    => '5',
        :ups_serial      => '1324',
        :ups_bus         => 'pci',
        :ups_driver      => 'somedriver',
        :ups_description => 'Test Config',
      }
    end
    let(:expected) do
"[someups]
  desc = \"Test Config\"
  driver = somedriver
  port = ttyS0
  vendorid = 0xid
  productid = 0xpd
  offdelay = 20
  ondelay = 10
  pollfreq = 5
  serial = 1324
  bus = pci
"
    end

    it { should include_class('concat::setup') }
    it { should contain_concat__fragment('nut_add_ups_sample2').with_target('/etc/nut/ups.conf').with_content(expected) }
  end
end
