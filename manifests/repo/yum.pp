# == Defined Type sabnzbd::repo::yum
#
# This class is called from sabnzbd for setup of yum.
#
define sabnzbd::repo::yum {
  $repo = regsubst(regsubst($title,'/','_','G'),':','','G')
  ensure_resource('yumrepo', $repo,
    {'ensure' => 'present', 'baseurl' => $title })
}
