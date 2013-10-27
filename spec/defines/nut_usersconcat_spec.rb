require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'nut::usersconcat' do

  let(:title) { 'nut::usersconcat' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) do
    {
      :ipaddress       => '10.42.42.42',
      :operatingsystem => 'Debian',
      :concat_basedir  => '/var/lib/puppet/concat'
    }
  end

  describe 'Test upsd.users is created with no options' do
    let(:params) do
      {
        :name => 'sample1',
      }
    end
    let(:expected) do
"[sample1]
  password = password
"
    end
    it { should contain_concat__fragment('nut_add_user_sample1').with_target('/etc/nut/upsd.users').with_content(expected) }
  end

  describe 'Test upsd.users is created with all main options' do
    let(:params) do
      {
        :name             => 'sample2',
        :user_name        => 'john',
        :user_password    => 'doe',
        :user_actions     => 'someaction',
        :user_instcmds    => ['command1', 'command2'],
        :user_upsmon_mode => 'master',
      }
    end
    let(:expected) do
"[john]
  password = doe
  actions = someaction
  instcmds = command1
  instcmds = command2
  upsmon master
"
    end

    it { should contain_concat__fragment('nut_add_user_sample2').with_target('/etc/nut/upsd.users').with_content(expected) }
  end
end
