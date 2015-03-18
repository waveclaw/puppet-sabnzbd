# == Defined Type sabnzbd::repo::ppa
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::ppa {
  $repo = regsubst(regsubst($title,'/','_'),':','')
  ensure_resource('apt::source', $repo,
    {'ensure' => 'present', 'location' => $title, 'repos' => 'main' })
}
