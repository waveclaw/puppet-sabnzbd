# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
class sabnzbd::config (
  $file   = hiera('sabnzbd::config::file', $::sabnzbd::defaults::configfile),
  $home   = hiera('sabnzbd::config::home', $::sabnzbd::defaults::home),
  $user   = hiera('sabnzbd::config::user', $::sabnzbd::defaults::user),
  $group  = hiera('sabnzbd::config::group', $::sabnzbd::defaults::group),
  $apikey = hiera('sabnzbd::config::apikey', $::sabnzbd::defaults::apikey),
) inherits sabnzbd::defaults {
  validate_hash($file)
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  $pathname = $file['path']
  $basename = $file['file']
  $target = "${pathname}/${basename}"
  if has_key($file, 'source') {
    file { $target: source => $file['source'], }
  } elsif has_key($file, 'template') {
    file { $target: content => template($file['template']), }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}
