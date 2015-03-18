# == Class sabnzbd::service
#
# This class is meant to be called from sabnzbd.
# It ensure the service is running.
#
class sabnzbd::service (
  $service,
){

  service { [$service]:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
