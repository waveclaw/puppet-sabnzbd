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
) {
  class { '::sabnzbd::repo': } ->
  class { '::sabnzbd::install': } ->
  class { '::sabnzbd::config': } ~>
  class { '::sabnzbd::service': } ->
  Class['::sabnzbd']
}
