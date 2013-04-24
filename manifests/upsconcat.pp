# This define APPENDS a ups to ups.conf file
#
define nut::upsconcat (
  $ups_name = '',
  $ups_port = '',
  $ups_driver = '',
  $ups_description = '',
  $order = '50',
  $ensure = 'present') {

  include concat::setup
  include nut

  $concat_ups_file = $nut::server_upsdrivers_config_file

  $real_ups_name = $ups_name ? {
    ''      => $name,
    default => $ups_name,
  }

  $real_ups_port = $ups_port ? {
    ''      => 'auto',
    default => $ups_port,
  }

  $real_ups_description = $ups_description ? {
    ''      => 'Local UPS',
    default => $ups_description,
  }

  $real_ups_driver = $ups_driver ? {
    ''      => 'usbhid-ups',
    default => $ups_driver,
  }

  if ! defined(Concat[$concat_ups_file]) {
    concat { $concat_ups_file:
      mode    => '0644',
      warn    => true,
      owner   => $nut::config_file_owner,
      group   => $nut::config_file_group,
      require => Package[$nut::server_package],
    }
  }

  concat::fragment { "nut_add_ups_${name}":
    ensure  => $ensure,
    target  => $concat_ups_file,
    content => template($nut::server_upsdrivers_template),
    order   => $order,
    notify  => Service[$nut::server_service],
  }
}

