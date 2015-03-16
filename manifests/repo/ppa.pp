# == Defined Type sabnzbd::repo::ppa
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::ppa (
  $title,
){
  $name = regsubst($title,'/','_')
  ensure_resource('ppa', $name, {'ensure' => 'present' })
}
