# == Defined Type sabnzbd::repo::ppa
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::ppa (
  $title,
){
  $name = regsubst(regsubst($title,'/','_'),':','')
  ensure_resource('apt::source', $name,
    {'ensure' => 'present', 'location' => $name, 'repos' => 'main' })
}
