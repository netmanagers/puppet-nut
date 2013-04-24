# Puppet module: nut

This is a Puppet module for nut based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Sebastian Quaino / Netmanagers

Official site: http://www.netmanagers.com.ar

Official git repository: http://github.com/netmanagers/puppet-nut

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* All parameters can be set using Hiera. See the manifests to see what can be set.

* Install nut with default settings. By default, we just install nut client.

        class { 'nut': }

* Install nut server (and client), with a local UPS. As we have many options and they handle 
  so many different parts, we assume nothing (there's room for improvement, though):

        class { 'nut':
          install_mode            => 'server',
          server_ups_name         => 'localUPS',
          server_ups_driver       => 'some_driver',
          server_ups_port         => 'auto',
          server_ups_description  => 'My UPS',
          server_user_name        => 'myuser',
          server_user_password    => 'secret',
          server_user_actions     => 'SET FSD',
          server_user_instcmds    => 'ALL',
          server_user_upsmon_mode => 'master',
          client_name             => 'localUPS',
          client_server_host      => 'localhost',
          client_user             => 'myuser',
          client_password         => 'secret',
          client_ups_mode         => 'master',
        }

* Install a specific version of nut package

        class { 'nut':
          version => '1.0.1',
        }

* Disable nut service.

        class { 'nut':
          disable => true
        }

* Remove nut package

        class { 'nut':
          absent => true
        }

* Enable auditing without without making changes on existing nut configuration *files*

        class { 'nut':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'nut':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'nut':
          source => [ "puppet:///modules/example42/nut/nut.conf-${hostname}" , "puppet:///modules/example42/nut/nut.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'nut':
          source_dir       => 'puppet:///modules/example42/nut/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'nut':
          template => 'example42/nut/nut.conf.erb',
        }

* Automatically include a custom subclass

        class { 'nut':
          my_class => 'example42::my_nut',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'nut':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'nut':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'nut':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'nut':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-nut.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-nut]
