# == Class: sabnzbd
#
# Organizes installation of Sabnzbd, the users and services.
#
# === Parameters
#
# [*user_name, group_name, user_home*]
#  User to run service as.  Defaults to sabnzbd.
#
# [*repo_name*]
#  Operating System specific name of package repositories to use.
#
# [*package_name*]
#  Operating System specific name of package(s) to install.
#
# [*service_name*]
#  Operating System specific name of the service(s) to run.
#
# [*config_file_path*]
#  Where to install the configuration file. Defaults to
#  /var/lib/sabnzbd/.config.
#
# [*sysconfig_file_path*]
#  Where to install the runcontrol script's configuration file. OS dependant.
#
# [*sysconfig_file_name*]
#  Name of the runcontrol script's configuration file.  OS dependant.
#
# [*download_dir*]
#  Where to keep finished files.  Defaults to /var/lib/sanbzbd/Downloads
#
# [*incomplete_dir*]
#  Where to keep unfinished files.  Defaults to /var/lib/sanbzbd/Incomplete
#
# [*apikey*]
#  The API key for the server.  Obtainable from the running instance.
#
# [*rating_api_key*]
#  The API key for the server's rating service.  Obtainable from the running
#  instance.
#
# [*nzb_key*]
#  The API key for just submitting NZB files.  Obtainable from the running
#  instance.
#
# [*webuser*]
#  Optional user for login to the Web UI. Empty by default.
#
# [*webpass*]
#  Password for the optional user for login to the Web UI. Empty by default.
#
# [*servers*]
#  Hash of Usenet servers containing further hashes of settings for servers.
#  This is not set by default but can be obtained from the config file
#  of a running instance.
#
#
class sabnzbd (
  $user_name           = $::sabnzbd::defaults::user_name,
  $user_home           = $::sabnzbd::defaults::user_home,
  $group_name          = $::sabnzbd::defaults::group_name,
  $repo_name           = $::sabnzbd::defaults::repo_name,
  $package_name        = $::sabnzbd::defaults::package_name,
  $service_name        = $::sabnzbd::defaults::service_name,
  $config_file_path    = $::sabnzbd::defaults::confg_file_path,
  $sysconfig_file_path = $::sabnzbd::defaults::sysconfig_file_path,
  $sysconfig_file_name = $::sabnzbd::defaults::sysconfig_file_name,
  $download_dir        = $::sabnzbd::defaults::download_dir,
  $incomplete_dir      = $::sabnzbd::defaults::incomplete_dir,
  $apikey              = $::sabnzbd::defaults::apikey,
  $rating_api_key      = $::sabnzbd::defaults::rating_api_key,
  $nzb_key             = $::sabnzbd::defaults::nzb_key,
  $webuser             = $::sabnzbd::defaults::webuser,
  $webpass             = $::sabnzbd::defaults::webpass,
  $servers             = $::sabnzbd::defaults::servers,
) inherits ::sabnzbd::defaults {

  validate_string($user_name)
  validate_string($user_home)
  validate_string($group_name)
  #$repo_name
  #$package_name
  #$service_name
  validate_string($config_file_path)
  validate_string($sysconfig_file_path)
  validate_string($sysconfig_file_name)
  validate_string($download_dir)
  validate_string($incomplete_dir)
  validate_string($apikey)
  validate_string($rating_api_key)
  validate_string($nzb_key)
  #$webuser
  #$webpass
  validate_hash($servers)

  class { '::sabnzbd::users': } ->
  class { '::sabnzbd::repo': } ->
  class { '::sabnzbd::install': } ->
  class { '::sabnzbd::sysconfig': } ->
  class { '::sabnzbd::config': } ->
  class { '::sabnzbd::service': } ->
  Class['::sabnzbd']

  Class ['::sabnzbd::sysconfig','::sabnzbd::config'] ~>
  Class ['::sabnzbd::service']
}
