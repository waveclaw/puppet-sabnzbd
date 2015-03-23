# == Class sabnzbd::defaults
#
# This class is meant to be called from sabnzbd.
# It sets variables according to platform.
#
class sabnzbd::defaults {
  $apikey = '"check https://localhost:9090/config/general/ for your apikey"'
  case $::osfamily {
    'Debian': {
      $packages = [ 'sabnzbdplus', 'sabnzbdplus-theme-modile']
      $services = 'sabnzbdplus'
      $repos    = 'ppa:jcfp/ppa'
      $configfile = { 'file' => 'sabnzbdplus', 'path' => '/etc/defaults',
        'template' => 'sabnzbd/sabnzbdplus.erb' }


    }
    'RedHat': {
      $packages = 'sabnzbd'
      $services = 'sabnzbd'
      $repos    = [
        join([ 'https://dl.dropboxusercontent.com/u/14500830/SABnzbd',
          'RHEL-CentOS', $::os_maj_version], '/'),
        join([ 'http://dl.fedoraproject.org/pub/epel',
          $::os_maj_version, $::architecture ], '/'),
        join([ 'http://packages.atrpms.net/dist',
          "el${::os_maj_version}",'unrar','' ], '/')
      ]
      $configfile = { 'file' => 'SABnzbd', 'path' => '/etc/sysconfig',
        'template'          => 'sabnzbd/sabnzbd.erb' }
    }
    'Suse': {
      # Push dependencies into package!
      $packages = 'sabnzbd'
      $services = 'sabnzbd'
      $repos    = [
        join([ 'http://download.opensuse.org/repositories',
          'Archiving/SLE_12'],'/'),
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
      $configfile = { 'file' => 'SABnzbd', 'path' => '/etc/sysconfig',
        'template'          => 'sabnzbd/sabnzbd.erb' }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
