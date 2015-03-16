# == Defined Type sabnzbd::repo::yum
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::yum (
  $title,
){
  $name = regsubst($title,'/','_')
  ensure_resource('yum', $name, {'ensure' => 'present' })
}
