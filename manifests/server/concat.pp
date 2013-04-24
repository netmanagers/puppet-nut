# This class builds the upsd.conf file using RIPienaar's concat module
# We build it using several fragments.
# Being the sequence of lines important we define these boundaries:
# 01 - General header
#
class nut::server::concat {

  include nut
  include concat::setup

  concat { $nut::server_config_file:
    mode    => $nut::config_file_mode,
    owner   => $nut::config_file_owner,
    group   => $nut::config_file_group,
    warn    => true,
    notify  => Service[$nut::server_service],
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

