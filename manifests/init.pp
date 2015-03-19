# == Class: sabnzbd
#
# Full description of class sabnzbd here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class sabnzbd (
  $repository_name = $::sabnzbd::defaults::repo,
  $package_name    = $::sabnzbd::defaults::package_name,
  $service_name    = $::sabnzbd::defaults::service_name,
) inherits sabnzbd::defaults {

  # validate parameters here

  class { '::sabnzbd::repo': repo       => $repository_name, } ->
  class { '::sabnzbd::install': package => $package_name, } ->
  class { '::sabnzbd::config': } ~>
  class { '::sabnzbd::service': service => $service_name, } ->
  Class['::sabnzbd']
}
