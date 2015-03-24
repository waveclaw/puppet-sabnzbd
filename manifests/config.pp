# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
# (The actual sabndbz.ini file is in the profile::mediaserver module)
#
class sabnzbd::config (
  $sysconf = hiera('sabnzbd::config::sysconf', $::sabnzbd::defaults::sysconf),
  $ini     = hiera('sabnzbd::config::ini', $::sabnzbd::defaults::ini),
  $home    = hiera('sabnzbd::config::home', $::sabnzbd::defaults::home),
  $user    = hiera('sabnzbd::config::user', $::sabnzbd::defaults::user),
  $group   = hiera('sabnzbd::config::group', $::sabnzbd::defaults::group),
  $apikey  = hiera('sabnzbd::config::apikey', $::sabnzbd::defaults::apikey),
) inherits sabnzbd::defaults {
  validate_hash($sysconf)
  validate_hash($ini)
  validate_string($home)
  validate_string($user)
  validate_string($group)
  validate_string($apikey)
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }
  $confpath = $sysconf['path']
  $confname = $sysconf['file']
  $conf = "${confpath}/${confname}"
  if has_key($sysconf, 'source') {
    file { $conf: source => $sysconf['source'], }
  } elsif has_key($conf, 'template') {
    file { $conf: content => template($sysconf['template']), }
  } else {
    notice('No source for configuration file, none will be used.')
  }
  # what about $home/sabnzbd.ini ?
  $pathname = $ini['path']
  file { $pathname:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0750',
  }
  $basename = $ini['file']
  $target = "${pathname}/${basename}"
  if has_key($ini, 'source') {
    file { $target:
      source => $ini['source'],
      owner  => $user,
      group  => $group,
      mode   => '0600',
    }
  } elsif has_key($ini, 'template') {
    file { $target:
      content => template($ini['template']),
      owner   => $user,
      group   => $group,
      mode    => '0600',
    }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}
