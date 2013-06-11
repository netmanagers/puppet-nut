# = Class: nut
#
# This is the main nut class
#
#############################################################################
# == Parameters
#
# Pay attention that we have five kind of parameters:
#
# * General/module parameters: these affect the general behaviour of the module
#   Many of them are standard example42 parameters
#
# * Server parameters ( $nut::server* ): these configure upsd daemon and module behaviour
#   regarding the server.
# * UPS drivers ( $nut::server_ups* ): needed by the upsd to connect to the UPS.
# * upsd users ( $nut::server_user* ): configure the permissions related to access to the server.
# * Client parameters ( $nut::client_*): these configure upsmon daemon and module behaviour
#   regarding the client.
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*process_args*]
#   The name of nut arguments. Used by puppi and monitor.
#   Used only in case the nut process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user nut runs with. Used by puppi and monitor.
#
# [*start_mode*]
#   The type of the service start: "netserver", "netclient", "standalone" or "none".
#   Default: netclient
#
# [*install_mode*]
#   The type of installation: "server" or "client".
#   Default: client
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, nut class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $nut_myclass
#
# [*source_dir*]
#   If defined, the whole nut configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $nut_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $nut_source_dir_purge
#
# [*client_template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, nut main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $nut_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $nut_options
#
# [*service_autorestart*]
#   Automatically restarts the nut service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $nut_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $nut_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $nut_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $nut_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for nut checks
#   Can be defined also by the (top scope) variables $nut_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $nut_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $nut_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $nut_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $nut_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for nut port(s)
#   Can be defined also by the (top scope) variables $nut_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling nut. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $nut_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $nut_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $nut_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $nut_audit_only
#   and $audit_only
#
# [*service_status*]
#   If the nut service init script supports status argument
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# ###############################
# ### Client (upsmon) parameters.
#
# [*client_package*]
#   The name of nut client package
#
# [*client_service*]
#   The name of nut client service
#
# [*client_process*]
#   The name of nut client_process
#
# [*client_config_file*]
#   Main configuration file path to the nut client
#
# [*client_pid_file*]
#   Path of pid file. Used by monitor
#
# [*client_source*]
#   Sets the content of source parameter for main configuration file
#   If defined, nut main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $nut_source
#
# [*client_name*]
# [*client_user*]
# [*client_password*]
# [*client_minsupplies*]
# [*client_finaldelay*]
# [*client_deadtime*]
# [*client_hostsync*]
# [*client_nocommwarmtime*]
# [*client_pollfreq*]
# [*client_pollfreqalert*]
# [*client_powerdownflag*]
# [*client_powervalue*]
# [*client_rbwarntime*]
# [*client_run_as_user*]
# [*client_server_host*]
# [*client_shutdowncmd*]
# [*client_ups_mode*]
#
# [*client_notifycmd*]
#   upsmon calls this to send messages when things happen
#   This command is called with the full text of the message as one argument.
#   Note that this is only called for [*client_notifyflag_* *] events that have EXEC set.
#
# [*client_notifyflag_commbad*]
# [*client_notifyflag_commonk*]
# [*client_notifyflag_fsd*]
# [*client_notifyflag_lowbat*]
# [*client_notifyflag_nocomm*]
# [*client_notifyflag_noparent*]
# [*client_notifyflag_onbat*]
# [*client_notifyflag_online*]
# [*client_notifyflag_remplbatt*]
# [*client_notifyflag_shutdown*]
#   The value for these parameters are any combination of 'SYSLOG', 'WALL' and 'EXEC',
#   concatenated with +, like SYSLOG+EXEC or SYSLOG+WALL+EXEC.
#   Default: empty
#
# [*client_notify_msg_commbad*]
# [*client_notify_msg_commonk*]
# [*client_notify_msg_fsd*]
# [*client_notify_msg_nocomm*]
# [*client_notify_msg_noparent*]
# [*client_notify_msg_online*]
# [*client_notify_msg_remplbatt*]
# [*client_notify_msg_shutdown*]
# [*client_notify_msg_onbat*]
# [*client_notify_msg_lowbat*]
#   Examples of messages:
#     $client_notify_msg_online = 'UPS %s on line power'
#     $client_notify_onbat = 'UPS %s on battery'
#     $client_notify_lowbat = 'UPS %s battery is low'
#     $client_notify_msg_fsd = 'UPS %s: forced shutdown in progress'
#     $client_notify_msg_commonk = 'Communications with UPS %s established'
#     $client_notify_msg_commbad = 'Communications with UPS %s lost'
#     $client_notify_msg_shutdown = 'Auto logout and shutdown proceeding'
#     $client_notify_msg_remplbatt = 'UPS %s battery needs to be replaced'
#     $client_notify_msg_nocomm = 'UPS %s is unavailable'
#     $client_notify_msg_noparent ='client parent process died - shutdown impossible'
#
# ###############################
# ### Server daemon (upsd) parameters.
#
# [*server_service*]
#   The name of nut server service
#
# [*server_process*]
#   The name of nut server process
#
# [*server_config_file*]
#   Main configuration file path to the nut server
#
# [*server_upsdrivers_config_file*]
#   Main configuration file path to the nut server drivers file
#   This is where you configure your ups drivers
#
# [*server_pid_file*]
#   Path of pid file. Used by monitor
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $nut_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $nut_protocol
#
# [*server_concat_template_footer*]
# [*server_concat_template_header*]
# [*server_config_type*]
# [*server_listen_ip*]
# [*server_package*]
# [*server_source*]
# [*server_template*]
# [*server_ups_description*]
# [*server_ups_driver*]
# [*server_upsdrivers_template*]
# [*server_ups_name*]
# [*server_ups_port*]
#
# [*server_user_actions*]
# [*server_user_concat_template*]
# [*server_user_config_file*]
# [*server_user_instcmds*]
# [*server_user_name*]
# [*server_user_password*]
# [*server_user_upsmon_mode*]
#
# See README for usage patterns.
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#   Sebastian Quaino <sebastian@netmanagers.com.ar/>
#   Javier Bertoli <javier@netmanagers.com.ar/>
#
class nut (
  $my_class                      = params_lookup( 'my_class' ),
  $client_source                 = params_lookup( 'client_source' ),
  $server_source                 = params_lookup( 'server_source' ),
  $source_dir                    = params_lookup( 'source_dir' ),
  $source_dir_purge              = params_lookup( 'source_dir_purge' ),
  $server_template               = params_lookup( 'server_template' ),
  $client_template               = params_lookup( 'client_template' ),
  $server_concat_template_header = params_lookup( 'server_concat_template_header' ),
  $server_concat_template_footer = params_lookup( 'server_concat_template_footer' ),
  $nutconf_template              = params_lookup( 'nutconf_template' ),
  $service_autorestart           = params_lookup( 'service_autorestart' , 'global' ),
  $options                       = params_lookup( 'options' ),
  $version                       = params_lookup( 'version' ),
  $absent                        = params_lookup( 'absent' ),
  $disable                       = params_lookup( 'disable' ),
  $disableboot                   = params_lookup( 'disableboot' ),
  $monitor                       = params_lookup( 'monitor' , 'global' ),
  $monitor_tool                  = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target                = params_lookup( 'monitor_target' , 'global' ),
  $puppi                         = params_lookup( 'puppi' , 'global' ),
  $puppi_helper                  = params_lookup( 'puppi_helper' , 'global' ),
  $firewall                      = params_lookup( 'firewall' , 'global' ),
  $firewall_tool                 = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src                  = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst                  = params_lookup( 'firewall_dst' , 'global' ),
  $debug                         = params_lookup( 'debug' , 'global' ),
  $audit_only                    = params_lookup( 'audit_only' , 'global' ),
  $noops                         = params_lookup( 'noops' ),
  $client_package                = params_lookup( 'client_package' ),
  $client_service                = params_lookup( 'client_service' ),
  $client_config_file            = params_lookup( 'client_config_file' ),
  $client_process                = params_lookup( 'client_process' ),
  $server_package                = params_lookup( 'server_package' ),
  $server_service                = params_lookup( 'server_service' ),
  $server_process                = params_lookup( 'server_process' ),
  $service_status                = params_lookup( 'service_status' ),
  $process_args                  = params_lookup( 'process_args' ),
  $process_user                  = params_lookup( 'process_user' ),
  $config_dir                    = params_lookup( 'config_dir' ),
  $server_upsdrivers_config_file = params_lookup( 'server_upsdrivers_config_file' ),
  $server_upsdrivers_template    = params_lookup( 'server_upsdrivers_template' ),
  $server_listen_ip              = params_lookup( 'server_listen_ip' ),
  $server_ups_name               = params_lookup( 'server_ups_name' ),
  $server_ups_driver             = params_lookup( 'server_ups_driver' ),
  $server_ups_port               = params_lookup( 'server_ups_port' ),
  $server_ups_description        = params_lookup( 'server_ups_description' ),
  $server_user_config_file       = params_lookup( 'server_user_config_file' ),
  $server_user_concat_template   = params_lookup( 'server_user_concat_template' ),
  $server_user_name              = params_lookup( 'server_user_name' ),
  $server_user_password          = params_lookup( 'server_user_password' ),
  $server_user_actions           = params_lookup( 'server_user_actions' ),
  $server_user_instcmds          = params_lookup( 'server_user_instcmds' ),
  $server_user_upsmon_mode       = params_lookup( 'server_user_upsmon_mode' ),
  $server_config_file            = params_lookup( 'server_config_file' ),
  $config_file_mode              = params_lookup( 'config_file_mode' ),
  $config_file_owner             = params_lookup( 'config_file_owner' ),
  $config_file_group             = params_lookup( 'config_file_group' ),
  $config_file_init              = params_lookup( 'config_file_init' ),
  $client_pid_file               = params_lookup( 'client_pid_file' ),
  $server_pid_file               = params_lookup( 'server_pid_file' ),
  $data_dir                      = params_lookup( 'data_dir' ),
  $log_dir                       = params_lookup( 'log_dir' ),
  $log_file                      = params_lookup( 'log_file' ),
  $port                          = params_lookup( 'port' ),
  $protocol                      = params_lookup( 'protocol' ),
  $install_mode                  = params_lookup( 'install_mode' ),
  $start_mode                    = params_lookup( 'start_mode' ),
  $client_run_as_user            = params_lookup( 'client_run_as_user' ),
  $client_name                   = params_lookup( 'client_name' ),
  $client_server_host            = params_lookup( 'client_server_host' ),
  $client_powervalue             = params_lookup( 'client_powervalue' ),
  $client_user                   = params_lookup( 'client_user' ),
  $client_password               = params_lookup( 'client_password' ),
  $client_ups_mode               = params_lookup( 'client_ups_mode' ),
  $client_minsupplies            = params_lookup( 'client_minsupplies' ),
  $client_shutdowncmd            = params_lookup( 'client_shutdowncmd' ),
  $client_notifycmd              = params_lookup( 'client_notifycmd' ),
  $client_pollfreq               = params_lookup( 'client_pollfreq' ),
  $client_pollfreqalert          = params_lookup( 'client_pollfreqalert' ),
  $client_hostsync               = params_lookup( 'client_hostsync' ),
  $client_deadtime               = params_lookup( 'client_deadtime' ),
  $client_powerdownflag          = params_lookup( 'client_powerdownflag' ),
  $client_notify_msg_online      = params_lookup( 'client_notify_msg_online' ),
  $client_notify_msg_onbat       = params_lookup( 'client_notify_msg_onbat' ),
  $client_notify_msg_lowbat      = params_lookup( 'client_notify_msg_lowbat' ),
  $client_notify_msg_fsd         = params_lookup( 'client_notify_msg_fsd' ),
  $client_notify_msg_commonk     = params_lookup( 'client_notify_msg_commonk' ),
  $client_notify_msg_commbad     = params_lookup( 'client_notify_msg_commbad' ),
  $client_notify_msg_shutdown    = params_lookup( 'client_notify_msg_shutdown' ),
  $client_notify_msg_remplbatt   = params_lookup( 'client_notify_msg_remplbatt' ),
  $client_notify_msg_nocomm      = params_lookup( 'client_notify_msg_nocomm' ),
  $client_notify_msg_noparent    = params_lookup( 'client_notify_msg_noparent' ),
  $client_notifyflag_online      = params_lookup( 'client_notifyflag_online' ),
  $client_notifyflag_onbat       = params_lookup( 'client_notifyflag_onbat' ),
  $client_notifyflag_lowbat      = params_lookup( 'client_notifyflag_lowbat' ),
  $client_notifyflag_fsd         = params_lookup( 'client_notifyflag_fsd' ),
  $client_notifyflag_commonk     = params_lookup( 'client_notifyflag_commonk' ),
  $client_notifyflag_commbad     = params_lookup( 'client_notifyflag_commbad' ),
  $client_notifyflag_shutdown    = params_lookup( 'client_notifyflag_shutdown' ),
  $client_notifyflag_remplbatt   = params_lookup( 'client_notifyflag_remplbatt' ),
  $client_notifyflag_nocomm      = params_lookup( 'client_notifyflag_nocomm' ),
  $client_notifyflag_noparent    = params_lookup( 'client_notifyflag_noparent' ),
  $client_rbwarntime             = params_lookup( 'client_rbwarntime' ),
  $client_nocommwarmtime         = params_lookup( 'client_nocommwarmtime' ),
  $client_finaldelay             = params_lookup( 'client_finaldelay' ),
  $server_config_type            = params_lookup( 'server_config_type' ),
  ) inherits nut::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_noops=any2bool($noops)

  ### Definition of some variables used in the module
  $manage_package = $nut::bool_absent ? {
    true  => 'absent',
    false => $nut::version,
  }

  $manage_service_enable = $nut::bool_disableboot ? {
    true    => false,
    default => $nut::bool_disable ? {
      true    => false,
      default => $nut::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $nut::bool_disable ? {
    true    => 'stopped',
    default =>  $nut::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_client_service_autorestart = $nut::bool_service_autorestart ? {
    true    => Service[$nut::client_service],
    false   => undef,
  }

  $manage_server_service_autorestart = $nut::bool_service_autorestart ? {
    true    => Service[$nut::server_service],
    false   => undef,
  }

  $manage_file = $nut::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $nut::bool_absent == true
  or $nut::bool_disable == true
  or $nut::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $nut::bool_absent == true
  or $nut::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $nut::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $nut::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_client_file_source = $nut::client_source ? {
    ''        => undef,
    default   => $nut::client_source,
  }

  $manage_server_file_source = $nut::server_source ? {
    ''        => undef,
    default   => $nut::server_source,
  }

  $manage_client_file_content = $nut::client_template ? {
    ''        => undef,
    default   => template($nut::client_template),
  }

  $manage_server_file_content = $nut::server_template ? {
    ''        => undef,
    default   => template($nut::server_template),
  }

  # The whole nut configuration directory can be recursively overriden
  if $nut::source_dir {
    file { 'ups.dir':
      ensure  => directory,
      path    => $nut::config_dir,
      require => Package[$nut::client_package],
      notify  => $nut::manage_client_service_autorestart,
      source  => $nut::source_dir,
      recurse => true,
      purge   => $nut::bool_source_dir_purge,
      force   => $nut::bool_source_dir_purge,
      replace => $nut::manage_file_replace,
      audit   => $nut::manage_audit,
      noop    => $nut::bool_noops,
    }
  }

  ## Nut.conf configuration
  include nut::nutconf

  ### Server configuration
  if $nut::install_mode == 'server' {
    include nut::server
  }

  include nut::client

  ### Include custom class if $my_class is set
  if $nut::my_class {
    include $nut::my_class
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $nut::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'nut':
      ensure    => $nut::manage_file,
      variables => $classvars,
      helper    => $nut::puppi_helper,
      noop      => $nut::bool_noops,
    }
  }

  ### Debugging, if enabled ( debug => true )
  if $nut::bool_debug == true {
    file { 'debug_nut':
      ensure  => $nut::manage_file,
      path    => "${settings::vardir}/debug-nut",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $nut::bool_noops,
    }
  }

}
