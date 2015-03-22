# == Class sabnzbd::repo
#
# This class is called from sabnzbd for setup of repos.
#
class sabnzbd::repo(
  $repos = hiera('sabnzbd::repo::repos', $::sabnzbd::defaults::repos),
) inherits sabnzbd::defaults {
  case $::osfamily {
    'Debian': {
      sabnzbd::repo::ppa { [$repos]: }
    }
    'RedHat': {
      sabnzbd::repo::yum { [$repos]: }
    }
    'Suse': {
      sabnzbd::repo::zyp { [$repos]: }
    }
    default: { }
  }
}
