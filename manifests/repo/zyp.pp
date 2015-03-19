# == Defined Type sabnzbd::repo::zyp
#
# This class is called from sabnzbd for setup of repos.
#
define sabnzbd::repo::zyp {
    $repo = regsubst(regsubst($title,'/','_','G'),':','','G')
    ensure_resource('zypprepo', $repo, { baseurl => $title })
}
