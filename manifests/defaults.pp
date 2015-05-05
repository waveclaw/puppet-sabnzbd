# == Class sabnzbd::defaults
#
# This class is meant to be called from sabnzbd.
# It sets variables according to platform.
#
class sabnzbd::defaults {
  $user_name           = 'sabnzbd'
  $group_name          = 'sabnzbd'
  $user_home           = '/var/lib/sabnzbd'
  $config_file_path    = "${user_home}/.config"
  $download_dir        = "${user_home}/Downloads"
  $incomplete_dir      = "${user_home}/Incomplete"
  $apikey              =
    '"check https://localhost:9090/config/general/ for your apikey"'
  $rating_api_key      =
    '"check https://localhost:9090/config/general/ for your apikey"'
  $nzb_key             =
    '"check https://localhost:9090/config/general/ for your apikey"'
  $webuser             = undef
  $webpass             = undef
  $servers             = undef
  case $::osfamily {
    # apt::source type is broken
    #'Ubuntu': {
    #  $sysconfig_file_path = '/etc/defaults'
    #  $sysconfig_file_name = 'sabnzbdplus'
    #  $repo_name = [ 'ppa:jcfp/ppa', ]
    #  $package_name = [ 'sabnzbdplus', 'sabnzbdplus-theme-mobile',
    #  'sabnzbdplus-theme-smpl', 'sabnzbdplus-theme-plush', 
    #  'sabnzbdplus-theme-iphone', ]
    #  $service_name = 'sabnzbdplus'
    #}
    'RedHat': {
      $sysconfig_file_path = '/etc/sysconfig'
      $sysconfig_file_name = 'sabnzbd'
      $package_name = 'sabnzbd'
      $service_name = 'sabnzbd'
      $repo_name = [
        join([ 'https://dl.dropboxusercontent.com/u/14500830/SABnzbd',
          'RHEL-CentOS', $::os_maj_version], '/'),
        join([ 'http://dl.fedoraproject.org/pub/epel',
          $::os_maj_version, $::architecture ], '/'),
        join([ 'http://packages.atrpms.net/dist',
          "el${::os_maj_version}",'unrar','' ], '/')
      ]
    }
    'Suse': {
      $sysconfig_file_path = '/etc/sysconfig'
      $sysconfig_file_name = 'sabnzbd'
      $package_name = 'sabnzbd'
      $service_name = 'sabnzbd'
      $repo_name = [
        join([ 'http://download.opensuse.org/repositories',
          'Archiving/SLE_12'],'/'),
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
