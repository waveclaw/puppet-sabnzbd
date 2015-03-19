# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
class sabnzbd::config (
  $rcfile,
) {
  validate_hash($rcfile)
  $path = $rcfile['path']
  $file = $rcfile['file']
  $type = $rcfile['type']
  file { "${path}/${file}":
    ensure => file,
    source => "puppet:///modules/sabnzbd/${type}.${::osfamily}",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
