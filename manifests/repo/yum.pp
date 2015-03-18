# == Defined Type sabnzbd::repo::yum
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::yum {
  $repo = regsubst(regsubst($title,'/','_'),':','_')
  ensure_resource('yumrepo', $repo,
    {'ensure' => 'present', 'baseurl' => $title })
}
