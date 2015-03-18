# == Class sabnzbd::repo
#
# This class is called from sabnzbd for setup of repos.
#
class sabnzbd::repo {
  case $::osfamily {
    'Debian': {
      sabnzbd::repo::ppa { [$::sabnzbd::repository_name]: }
    }
    'RedHat': {
      sabnzbd::repo::yum { [$::sabnzbd::repository_name]: }
    }
    'Suse': {
      sabnzbd::repo::zyp { [$::sabnzbd::repository_name]: }
    }
    default: { }
  }
}
