class nut::nutconf {

  include nut

  file { 'nut_conf':
    ensure  => $nut::manage_file,
    path    => $nut::nutconf_config_file,
    mode    => $nut::config_file_mode,
    owner   => $nut::config_file_owner,
    group   => $nut::config_file_group,
    notify  => $nut::manage_service_autorestart,
    source  => $nut::manage_nutconf_file_source,
    content => $nut::manage_nutconf_file_content,
    replace => $nut::manage_file_replace,
    audit   => $nut::manage_audit,
    noop    => $nut::bool_noops,
  }
}
