# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
# (The actual sabndbz.ini file is in the profile::mediaserver module)
#
class sabnzbd::config (
  $sysconf    = hiera('sabnzbd::config::sysconf',
    $::sabnzbd::defaults::sysconf),
  $iniconf    = hiera('sabnzbd::config::iniconf',
    $::sabnzbd::defaults::iniconf),
  $home       = hiera('sabnzbd::config::home', $::sabnzbd::defaults::home),
  $user       = hiera('sabnzbd::config::user', $::sabnzbd::defaults::user),
  $group      = hiera('sabnzbd::config::group', $::sabnzbd::defaults::group),
  $apikey     = hiera('sabnzbd::config::apikey', $::sabnzbd::defaults::apikey),
  $webpass    = hiera('sabnzbd::web::password', undef),
  $webuser    = hiera('sabnzbd::web::user', undef),
  $ratingkey  = hiera('sabnzbd::ratingkey', undef),
  $nzb_key    = hiera('sabnzbd::nsbkey', undef),
  $downloadcache = hiera('sabnzbd::downloadcache', undef),
  $downloadtarget = hiera('sabnzbd::downloadtarget', undef),
  $servers = hiera('sabnzbd::servers', undef),
) inherits sabnzbd::defaults {
  validate_hash($sysconf)
  validate_hash($iniconf)
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
  } elsif has_key($sysconf, 'template') {
    file { $conf: content => template($sysconf['template']), }
  } else {
    notice('No source for configuration file, none will be used.')
  }
  # what about $home/sabnzbd.ini ?
  $pathname = $iniconf['path']
  file { $pathname:
    ensure    => directory,
    owner     => $user,
    group     => $group,
    mode      => '0750',
    show_diff => false,
  }
  $basename = $iniconf['file']
  $inifile = "${pathname}/${basename}"
  if has_key($iniconf, 'source') {
    file { $inifile:
      source    => $iniconf['source'],
      owner     => $user,
      group     => $group,
      mode      => '0600',
      show_diff => false,
    }
  } elsif has_key($iniconf, 'template') {
    file { $inifile:
      content   => template($iniconf['template']),
      owner     => $user,
      group     => $group,
      mode      => '0600',
      show_diff => false,
    }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}
