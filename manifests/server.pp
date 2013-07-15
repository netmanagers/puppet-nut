# = Class: nut::server
#
# This class manages Nut server components
#
#
# == Parameters
#
# The parameters used in this class are defined for the main nut class
#
class nut::server {

  include nut

  ### Managed resources
  package { $nut::server_package:
    ensure => $nut::manage_package,
    name   => $nut::server_package,
    noop   => $nut::bool_noops,
  }

  # FIXME! This is a nasty hack, but in CentOS, nut-client and nut-server
  # have a single init script, so we check if it's not already defined
  if ! defined(Service[$nut::server_service]) {
    service { $nut::server_service:
      ensure    => $nut::manage_service_ensure,
      name      => $nut::server_service,
      enable    => $nut::manage_service_enable,
      hasstatus => $nut::service_status,
      pattern   => $nut::server_process,
      require   => Package[$nut::server_package],
      noop      => $nut::bool_noops,
    }
  }
  # How to manage upsd configuration
  case $nut::server_config_type {
    'file': { include nut::server::file }
    'concat': { include nut::server::concat }
    default: { }
  }

  if $nut::server_ups_name != '' {
    nut::upsconcat { $nut::server_ups_name:
      ups_port        => $nut::server_ups_port,
      ups_driver      => $nut::server_ups_driver,
      ups_description => $nut::server_ups_description,
      ups_vendor      => $nut::server_ups_vendor,
      ups_vendorid    => $nut::server_ups_vendorid,
      ups_product     => $nut::server_ups_product,
      ups_productid   => $nut::server_ups_productid,
      ups_offdelay    => $nut::server_ups_offdelay,
      ups_ondelay     => $nut::server_ups_ondelay,
      ups_pollfreq    => $nut::server_ups_pollfreq,
      ups_serial      => $nut::server_ups_serial,
      ups_bus         => $nut::server_ups_bus,
    }
  }

  if $nut::server_user_name != '' {
    nut::usersconcat { $nut::server_user_name:
      user_password    => $nut::server_user_password,
      user_actions     => $nut::server_user_actions,
      user_instcmds    => $nut::server_user_instcmds,
      user_upsmon_mode => $nut::server_user_upsmon_mode,
    }
  }

  ### Firewall management, if enabled ( firewall => true )
  if $nut::bool_firewall == true and $nut::port != '' {
    firewall { "nut_${nut::protocol}_${nut::port}":
      source      => $nut::firewall_src,
      destination => $nut::firewall_dst,
      protocol    => $nut::protocol,
      port        => $nut::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $nut::firewall_tool,
      enable      => $nut::manage_firewall,
      noop        => $nut::bool_noops,
    }
  }

  ### Service monitoring, if enabled ( monitor => true )
  if $nut::bool_monitor == true {
    if $nut::server_service != '' {
      monitor::process { 'nut_server_process':
      process  => $nut::server_process,
      service  => $nut::server_service,
      pidfile  => $nut::server_pid_file,
      user     => $nut::process_user,
      argument => $nut::process_args,
      tool     => $nut::monitor_tool,
      enable   => $nut::manage_monitor,
      noop     => $nut::bool_noops,
      }
    }
  }
}
