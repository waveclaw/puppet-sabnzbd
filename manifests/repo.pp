# == Class sabnzbd::repo
#
# This class is called from sabnzbd for setup of repos.
#
class sabnzbd::repo(
  $repositories = hiera('sabnzbd::repo::repos', $::sabnzbd::defaults::repos),
) inherits sabnzbd::defaults {
  case $::osfamily {
    'Debian': {
      sabnzbd::repo::ppa { [$repositories]: }
    }
    'RedHat': {
      sabnzbd::repo::yum { [$repositories]: }
    }
    'Suse': {
      sabnzbd::repo::zyp { [$repositories]: }
    }
    default: { }
  }
}
