# == Class sabnzbd::install
#
# This class is called from sabnzbd for install.
#
class sabnzbd::install {
  ensure_resource('package', $::sabnzbd::package_name,
    { 'ensure' => 'present' })
}
