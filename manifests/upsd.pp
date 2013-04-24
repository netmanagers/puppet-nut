# Define: nut::upsd
#
# Supported arguments:
# $jailname - The name you want to give the jail. If not set, defaults to == $aclname
# $order    - The order in the jail.local file. Default 50. Generally you don't need to change it
# $status   - enabled / disabled. If disabled, the rule _IS ADDED_  to the jail.local file
#             but it will not be active. Compare with the next one.
# $enable   - true / false. If false, the rule _IS NOT ADDED_ to the jail.local file
# $filter   - The filter rule to use. If empty, defaults to == $jailname.
# $port     - The port to filter. It can be an array of ports.
# $action   - The action to take when
# $logpath  - The log file to monitor
# $maxretry - How many fails are acceptable
# $bantime  - How much time to apply the ban, in seconds

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
