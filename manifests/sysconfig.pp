# == Class sabnzbd::sysconfig
#
# This class is called from sabnzbd for system control config
#
# Parameters
#
# [*source, content, template*]
#   Override the content on a whole-file basis. No default.
#   Templates will only have access to already defined variables.
#
class sabnzbd::sysconfig(
  $source       = undef,
  $content      = undef,
  $template     = undef,
){
  $_file_path      = $sabnzbd::sysconfig_file_path
  $_file_name      = $sabnzbd::sysconfig_file_name
  $_user_home      = $sabnzbd::config_file_path
  $_user           = $sabnzbd::user_name
  $_group          = $sabnzbd::group_name
  $_apikey         = $sabnzbd::apikey
  $_sysconfig_file = "${_file_path}/${_file_name}"
  File {
    owner  => $_user,
    group  => $_group,
    mode   => '0750',
  }
  ensure_resource('file', $_file_path, {
    'ensure' => 'directory',
    'owner'  => $_user,
    'group'  => $_group,
    'mode'   => '0750',
  })
  if $source != undef {
    file { $_sysconfig_file:
      ensure => file,
      source => $source,
    }
  } elsif $content != undef {
    file { $_sysconfig_file:
      ensure  => file,
      content => $content,
    }
  } elsif $template != undef {
    file { $_sysconfig_file:
      ensure  => file,
      content => $template,
    }
  } else {
    file { $_sysconfig_file:
      ensure  => file,
      content => template("sabnzbd/${_file_name}.erb"),
    }
  }
}
