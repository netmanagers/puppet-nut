class nut::server::file inherits nut {
  file { 'upsd.conf':
    ensure  => $nut::manage_file,
    path    => $nut::server_config_file,
    mode    => $nut::config_file_mode,
    owner   => $nut::config_file_owner,
    group   => $nut::config_file_group,
    require => Package[$nut::server_package],
    notify  => $nut::manage_server_service_autorestart,
    content => $nut::manage_server_file_content,
    replace => $nut::manage_file_replace,
    audit   => $nut::manage_audit,
  }
}
