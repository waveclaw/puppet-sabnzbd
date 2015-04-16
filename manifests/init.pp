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
  $repositories = hiera('sabnzbd::repositories',
    sabnzbd::defaults::repos),
  $services = hiera('sabnzbd::services', sabnzbd::defaults::services),
  $packages = hiera('sabnzbd::packages', sabnzbd::defaults::services),
  $config_template = undef,
) inherits sabnzbd::defaults {
  class { '::sabnzbd::repo': repositories      => $repositories, } ->
  class { '::sabnzbd::install': services       => $services, } ->
  class { '::sabnzbd::config': config_template => $config_template, } ~>
  class { '::sabnzbd::service': services       => $services, } ->
  Class['::sabnzbd']
}
