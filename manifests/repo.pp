# == Class sabnzbd::repo
#
# This class is called from sabnzbd for setup of repos.
#
class sabnzbd::repo(
) {
  $_repo = $sabnzbd::repo_name
  case $::osfamily {
    'Debian': {
      sabnzbd::repo::ppa { [$_repo]: }
    }
    'RedHat': {
      sabnzbd::repo::yum { [$_repo]: }
    }
    'Suse': {
      sabnzbd::repo::zyp { [$_repo]: }
    }
    default: { }
  }
}
