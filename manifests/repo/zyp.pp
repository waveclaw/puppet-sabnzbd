# == Defined Type sabnzbd::repo::zyp
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::zyp (
  $title,
){
  $name = regsubst(regsubst($title,'/','_'),':','')
  ensure_resource('zypprepo', $name,
    {'ensure' =>  'present', baseurl => $title })
}
