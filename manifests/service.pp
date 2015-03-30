# == Class sabnzbd::service
#
# This class is meant to be called from sabnzbd.
# It ensure the service is running.
#
class sabnzbd::service (
  $services = hiera('sabnzbd::service::services',
    $::sabnzbd::defaults::services),
) inherits sabnzbd::defaults {

  service { [$services]:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    start      => '/usr/sbin/stabnzbd start',
    stop       => '/usr/sbin/stabnzbd stop',
    status     => '/usr/sbin/stabnzbd status',
  }
}
