# == Class sabnzbd::repo
#
# This class is called from sabnzbd for setup of repos.
#
class sabnzbd::repo {
  case $::osfamily {
    'Debian': {
      sabnzbd::repo::ppa { [$::sabnzbd::repo_name]: }
    }
    'RedHat': {
      sabnzbd::repo::yum { [$::sabnzbd::repo_name]: }
    }
    'Suse': {
      sabnzbd::repo::zyp { [$::sabnzbd::repo_name]: }
    }
    default: { }
  }
}
