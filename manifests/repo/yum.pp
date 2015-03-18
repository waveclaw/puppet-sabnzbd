# == Defined Type sabnzbd::repo::yum
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::yum (
  $title,
){
  $name = regsubst(regsubst($title,'/','_'),':','_')
  ensure_resource('yumrepo', $name,
    {'ensure' => 'present', 'baseurl' => $title })
}
