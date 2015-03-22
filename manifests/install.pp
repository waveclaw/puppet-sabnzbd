# == Class sabnzbd::install
#
# This class is called from sabnzbd for install.
#
class sabnzbd::install (
  $packages = hiera('::sabnzbd::install::packages',
    $::sabnzbd::defaults::packages),
) inherits sabnzbd::defaults {
  ensure_resource('package', $packages,
    { 'ensure' => 'present' })
}
