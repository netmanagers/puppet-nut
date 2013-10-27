# Define: nut::upsd
#
# Supported arguments:
# $aclname - The name you want to give the acl. If not set, defaults to == $title
# $client  - The IP of the client
#            Default: 127.0.0.1
# $action  - One of ACCEPT / REJECT
#            Default: ACCEPT

define nut::upsd (
  $aclname = '',
  $client  = '',
  $action  = '',
  $enable  = true,
) {

  include nut

  $real_aclname = $aclname ? {
    ''      => $title,
    default => $aclname,
  }

  $real_client = $client ? {
    ''      => '127.0.0.1/8',
    default => $client,
  }

  $real_action = $action ? {
    ''      => 'ACCEPT',
    default => $action,
  }

  $ensure = bool2ensure($enable)

  if ! defined(Concat[$nut::server_config_file]) {
    concat { $nut::server_config_file:
      mode    => $nut::config_file_mode,
      owner   => $nut::config_file_owner,
      group   => $nut::config_file_group,
      warn    => true,
      notify  => Service[$nut::server_service],
      require => Package[$nut::server_package],
    }
 
    concat::fragment{ 'ups_server_header':
      target  => $nut::server_config_file,
      content => template($nut::server_concat_template_header),
      order   => 01,
      notify  => Service[$nut::server_service],
    }
 
    # The DEFAULT footer with the default policies
    concat::fragment{ 'ups_server_footer':
      target  => $nut::server_config_file,
      content => template($nut::server_concat_template_footer),
      order   => 99,
      notify  => Service[$nut::server_service],
    }
  }

  concat::fragment{ "nut_upsd_${real_aclname}":
    ensure  => $ensure,
    target  => $nut::server_config_file,
    content => template($nut::server_concat_template_stanza),
    order   => $real_order,
    notify  => Service[$nut::server_service],
  }
}
