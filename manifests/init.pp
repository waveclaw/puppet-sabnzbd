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
  $package_name = $::sabnzbd::defaults::package_name,
  $service_name = $::sabnzbd::defaults::service_name,
) inherits sabnzbd::defaults {

  # validate parameters here

  class { '::sabnzbd::install': } ->
  class { '::sabnzbd::config': } ~>
  class { '::sabnzbd::service': } ->
  Class['::sabnzbd']
}
