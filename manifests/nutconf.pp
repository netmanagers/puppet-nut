# Class nut::nutconf
#
# Manage nut.conf file for different distros.
# This class is not meant to be used alone as is called by other parts of the
# nut module.
#
class nut::nutconf {

  include nut

  $real_start_mode = $::operatingsystem ? {
    /(?i:CentOS|RedHat)/ => $nut::start_mode ? {
      /(?i:standalone|netserver)/ => 'yes',
      default                     => 'no',
    },
    default               => $nut::start_mode,
  }

  $manage_nutconf_file_source = $nut::nutconf_source ? {
    ''        => undef,
    default   => $nut::nutconf_source,
  }

  $manage_nutconf_file_content = $nut::nutconf_template ? {
    ''        => undef,
    default   => template($nut::nutconf_template),
  }

  file { 'nut_conf':
    ensure  => $nut::manage_file,
    path    => $nut::nutconf_config_file,
    mode    => $nut::config_file_mode,
    owner   => $nut::config_file_owner,
    group   => $nut::config_file_group,
    notify  => $nut::manage_service_autorestart,
    source  => $nutconf::manage_nutconf_file_source,
    content => $nutconf::manage_nutconf_file_content,
    replace => $nut::manage_file_replace,
    audit   => $nut::manage_audit,
    noop    => $nut::noops,
  }
}
