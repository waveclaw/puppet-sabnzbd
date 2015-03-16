# == Class sabnzbd::defaults
#
# This class is meant to be called from sabnzbd.
# It sets variables according to platform.
#
class sabnzbd::defaults {
  case $::osfamily {
    'Debian': {
      $package_name = 'sabnzbd'
      $service_name = 'sabnzbd'
    }
    'RedHat', 'Suse': {
      $package_name = 'sabnzbd'
      $service_name = 'sabnzbd'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
