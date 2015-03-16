# == Class sabnzbd::install
#
# This class is called from sabnzbd for install.
#
class sabnzbd::install {

  package { $::sabnzbd::package_name:
    ensure => present,
  }
}
