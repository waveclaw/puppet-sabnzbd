# == Class sabnzbd::install
#
# This class is called from sabnzbd for install.
#
class sabnzbd::install (
  $package = '',
){
  ensure_resource('package', [$package],
    { 'ensure' => 'present' })
}
