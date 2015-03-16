# == Class sabnzbd::install
#
# This class is called from sabnzbd for install.
#
class sabnzbd::install {
  ensure_packages([$::sabnzbd::package_name])
}
