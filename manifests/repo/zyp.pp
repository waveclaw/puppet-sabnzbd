# == Defined Type sabnzbd::repo::zyp
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::zyp {
  $repo = regsubst(regsubst($title,'/','_'),':','')
  ensure_resource('zypprepo', $repo,
    {'ensure' =>  'present', baseurl => $title })
}
