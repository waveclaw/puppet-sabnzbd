# == Class sabnzbd::defaults
#
# This class is meant to be called from sabnzbd.
# It sets variables according to platform.
#
class sabnzbd::defaults {
  case $::osfamily {
    'Debian': {
      $package_name = [ 'sabnzbdplus', 'sabnzbdplus-theme-modile']
      $service_name = 'sabnzbdplus'
      $repo = 'ppa:jcfp/ppa'
      $rcfile = { 'file' => 'sabnzbd', 'path' => '/etc/init.d',
        'type' =>'init' }

    }
    'RedHat': {
      $package_name = 'sabnzbd'
      $service_name = 'sabnzbd'
      $repo         = [
        join(['https:','','dl.dropboxusercontent.com','u',
          '14500830','SABnzbd','RHEL-CentOS', $::os_maj_version],'/'),
        join([ 'http:','','dl.fedoraproject.org','pub','epel',
          $::os_maj_version,$::architecture ],'/'),
        join([ 'http:','','packages.atrpms.net','dist',
          "el${::os_maj_version}",'unrar','' ],'/')
      ]
      $rcfile = { 'file' => 'sabnzbd', 'path' => '/etc/init.d',
        'type' => 'init' }
    }
    'Suse': {
      $package_name = ['SABnzbd', 'cheeta','unrar','par2']
      $service_name = 'sabnzbd'
      $repo         = [
        join([ 'http:','','download.opensuse.org',
          'repositories', 'home:','jjfalling:','branches:','home:',
          'chenxiaolong:','SABnzbd', 'openSUSE_13.2'],'/'),
        join(['http:','','download.opensuse.org','repositories',
          'Archiving','SLE_12'],'/')
      ]
      $rcfile = { 'file' => 'sabnzbd.service',
        'path' => '/usr/lib/systemd/system',
        'type'=> 'systemd' }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
