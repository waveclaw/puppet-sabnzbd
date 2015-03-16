# == Defined Type sabnzbd::repo::zyp
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::zyp (
  $title,
){
  $name = regsubst($title,'/','_')
  ensure_resource('zyp', $name, {'ensure' => 'present' })
}
