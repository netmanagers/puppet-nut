# This define APPENDS a user to upsd.users file
#
define nut::usersconcat (
  $user_name = '',
  $user_password = '',
  $user_actions = '',
  $user_instcmds = '',
  $user_upsmon_mode = '',
  $order = '50',
  $ensure = 'present') {

  include concat::setup
  include nut

  $concat_users_file = $nut::server_user_config_file

  $real_user_name = $user_name ? {
    ''      => $name,
    default => $user_name,
  }

  $real_user_password = $user_password ? {
    ''      => 'password',
    default => $user_password,
  }

  $real_user_actions= $user_actions? {
    ''      => '',
    default => $user_actions,
  }

  $real_user_upsmon_mode = $user_upsmon_mode ? {
    ''      => '',
    default => $user_upsmon_mode ,
  }

  $array_user_instcmds = is_array($user_instcmds) ? {
    false     => $user_instcmds ? {
      ''      => [],
      default => [$user_instcmds],
    },
    default   => $user_instcmds,
  }

  if ! defined(Concat[$concat_users_file]) {
    concat { $concat_users_file:
      mode    => '0640',
      warn    => true,
      owner   => $nut::config_file_owner,
      group   => $nut::config_file_group,
      require => Package[$nut::server_package],
    }
  }

  concat::fragment { "nut_add_user_${name}":
    ensure  => $ensure,
    target  => $concat_users_file,
    content => template($nut::server_user_concat_template),
    order   => $order,
    notify  => Service[$nut::server_service],
  }
}

