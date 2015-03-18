# == Class sabnzbd::repo
#
# This class is called from sabnzbd for setup of repos.
#
class sabnzbd::repo(
  $repo,
){
  case $::osfamily {
    'Debian': {
      sabnzbd::repo::ppa { [$repo]: }
    }
    'RedHat': {
      sabnzbd::repo::yum { [$repo]: }
    }
    'Suse': {
      sabnzbd::repo::zyp { [$repo]: }
    }
    default: { }
  }
}
