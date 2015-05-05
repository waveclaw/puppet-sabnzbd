# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
class sabnzbd::config(
  $config_file_source       = undef,
  $config_file_content      = undef,
  $config_file_template     = undef,
){
  $_config_file    = '/var/lib/sabnzbd/.config/sabnzbd.ini'
  $_apikey         = $sabnzbd::apikey
  $_rating_api_key = $sabnzbd::rating_api_key
  $_nzb_key        = $sabnzbd::nzb_key
  $_webuser        = $sabnzbd::webuser
  $_webpass        = $sabnzbd::webpass
  $_incomplete_dir = $sabnzbd::incomplete_dir
  $_download_dir   = $sabnzbd::download_dir
  $_servers        = $sabnzbd::servers
  $_dirs = [
    '/var/lib/sabnzbd',
    '/var/lib/sabnzbd/.config',
    '/var/lib/sabnzbd/logs',
    $_download_dir,
    $_incomplete_dir,
  ]
  File {
    owner  => $sabnzbd::user_name,
    group  => $sabnzbd::group_name,
    mode   => '0750',
  }
  ensure_resource( 'file' , $_dirs, {
    ensure => directory,
  })
  if $config_file_source != undef {
    file { $_config_file:
      ensure => file,
      source => $config_file_source,
    }
  } elsif $config_file_content != undef {
    file { $_config_file:
      ensure  => file,
      content => $config_file_content,
    }
  } elsif $config_file_template != undef {
    file { $_config_file:
      ensure  => file,
      content => $config_file_template,
    }
  } else {
    file { $_config_file:
      ensure  => file,
      content => template('sabnzbd/sabnzbd.ini.erb'),
    }
  }
}
