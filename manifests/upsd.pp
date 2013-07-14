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
  $action  = ''
) {

  include nut
  include concat::setup

  $real_aclname = $aclname ? {
    ''      => $title,
    default => $aclname,
  }

  $real_client = $client ? {
    ''      => '127.0.0.1',
    default => $client,
  }

  $real_action = $action ? {
    ''      => 'ACCEPT',
    default => $action,
  }

  $ensure = bool2ensure($enable)

  concat::fragment{ "nut_upsd_$name":
    ensure  => $ensure,
    target  => $nut::server_config_file,
    content => template($nut::server_concat_template_stanza),
    order   => $real_order,
    notify  => Service[$nut::server_service],
  }
}
