# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
class sabnzbd::config (
  $rcfile,
  $confile,
) {
  validate_hash($rcfile)
  validate_hash($confile)
  $rpath = $rcfile['path']
  $rfile = $rcfile['file']
  $rtype = $rcfile['type']
  file { "${rpath}/${rfile}":
    ensure => file,
    source => "puppet:///modules/sabnzbd/${rtype}.${::osfamily}",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  $cpath = $rcfile['path']
  $cfile = $rcfile['file']
  $csource = $rcfile['type']
  file { "${cpath}/${cfile}":
    source => $csource,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
