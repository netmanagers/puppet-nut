# Class: nut::params
#
# This class defines default parameters used by the main module class nut
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to nut class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class nut::params {

  $install_mode = 'client'

  $start_mode = 'netclient'

  ### Application related parameters

  $config_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/nut',
    default                   => '/etc/ups',
  }

  $nutconf_template = 'nut/nut.conf.erb'

  ### CLIENT parameters
  $client_package = $::operatingsystem ? {
    default => 'nut-client',
  }

  $client_service = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nut-client',
    default                   => 'ups',
  }

  $client_process = $::operatingsystem ? {
    default => 'upsmon',
  }

  $client_config_file = $::operatingsystem ? {
    default => "${config_dir}/upsmon.conf",
  }

  $client_pid_file = $::operatingsystem ? {
    default => '/var/run/nut/upsmon.pid',
  }

  $client_source = ''
  $client_template = 'nut/upsmon.conf.erb'

  ### SERVER parameters
  $server_package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nut-server',
    default                   => 'nut',
  }

  $server_service = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nut-server',
    default                   => 'ups',
  }

  $server_process = $::operatingsystem ? {
    default => 'upsd',
  }

  $server_config_file = $::operatingsystem ? {
    default => "${config_dir}/upsd.conf",
  }

  $server_pid_file = $::operatingsystem ? {
    default => '/var/run/nut/upsd.pid',
  }

  $server_config_type = 'concat'
  $server_source = ''
  $server_template = ''
  $server_concat_template_header = 'nut/concat/upsd.conf-header.erb'
  $server_concat_template_stanza = 'nut/concat/upsd.conf-stanza.erb'
  $server_concat_template_footer = 'nut/concat/upsd.conf-footer.erb'

  $server_listen_ip = ''

  $server_upsdrivers_config_file = $::operatingsystem ? {
    default => "${config_dir}/ups.conf",
  }

  $server_upsdrivers_template = 'nut/concat/ups.conf.erb'

  $server_ups_name = ''
  $server_ups_driver = ''
  $server_ups_port = ''
  $server_ups_description = ''

  $server_user_config_file = $::operatingsystem ? {
    default => "${config_dir}/upsd.users",
  }
  $server_user_concat_template = 'nut/concat/upsd.users.erb'
  $server_user_name = ''
  $server_user_password = ''
  $server_user_actions = ''
  $server_user_instcmds = ''
  $server_user_upsmon_mode = ''

  ### COMMON parameters
  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'nut',
  }


  $config_file_mode = $::operatingsystem ? {
    default => '0640',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'nut',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'nut',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/nut/nut.conf',
    default                   => '/etc/sysconfig/ups',
  }

  # FIXME! Needed?
  $data_dir = $::operatingsystem ? {
    default => '/etc/ups',
  }

  # FIXME! Needed?
  $log_dir = $::operatingsystem ? {
    default => '/var/log/nut',
  }

  # FIXME! Needed?
  $log_file = $::operatingsystem ? {
    default => '/var/log/nut/nut.log',
  }

  $port = '3493'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source_dir = ''
  $source_dir_purge = false
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

  ### CLIENT Template parameters
  $client_run_as_user = 'nut'
  $client_name = ''
  $client_server_host = ''
  $client_powervalue = '1'
  $client_user = ''
  $client_password = ''
  $client_ups_mode = 'slave'
  $client_minsupplies = '1'
  $client_shutdowncmd = '/sbin/shutdown -h +0'
  $client_notifycmd = '/usr/local/bin/nut-notify'
  $client_pollfreq = '5'
  $client_pollfreqalert = '2'
  $client_hostsync = '15'
  $client_deadtime = '12'
  $client_powerdownflag ='/etc/killpower'
  $client_notify_msg_online = ''
  $client_notify_msg_onbat = ''
  $client_notify_msg_lowbat = ''
  $client_notify_msg_fsd = ''
  $client_notify_msg_commonk = ''
  $client_notify_msg_commbad = ''
  $client_notify_msg_shutdown = ''
  $client_notify_msg_remplbatt = ''
  $client_notify_msg_nocomm = ''
  $client_notify_msg_noparent =''
  $client_notifyflag_online = ''
  $client_notifyflag_onbat = ''
  $client_notifyflag_lowbat = ''
  $client_notifyflag_fsd = ''
  $client_notifyflag_commonk = ''
  $client_notifyflag_commbad =''
  $client_notifyflag_shutdown = ''
  $client_notifyflag_remplbatt = ''
  $client_notifyflag_nocomm = ''
  $client_notifyflag_noparent = ''
  $client_rbwarntime = '43200'
  $client_nocommwarmtime = '300'
  $client_finaldelay ='5'
}
