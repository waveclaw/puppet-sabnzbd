# == Class: sabnzbd
#
# Configure SABnzbd, a Usenet binary downloader for NZB indexed files
#
# === Parameters
#
# [*repositories*]
#  The source for pacakges needed by SABnzbd.
#  hiera value sabnzbd::repo::repos
#
# [*services*]
#  Service(s) to start for SABnzbd.
#  hiera value sabnzbd::service::services
#
# [*packages*]
#  Packages to install for SABnzbd.
#  hiera value sabnzbd::install::packages
#
# [*config_template*]
#  Override the configuration template file.
#
class sabnzbd (
  $repositories = hiera('sabnzbd::repo::repos',
    $sabnzbd::defaults::repos),
  $packages = hiera('sabnzbd::install::packages',
    $sabnzbd::defaults::packages),
  $services = hiera('sabnzbd::service::services',
    $sabnzbd::defaults::services),
  $config_template = undef,
) inherits sabnzbd::defaults {
  class { '::sabnzbd::repo': repositories      => $repositories, } ->
  class { '::sabnzbd::install': packages       => $packages, } ->
  class { '::sabnzbd::config': config_template => $config_template, } ~>
  class { '::sabnzbd::service': services       => $services, } ->
  Class['::sabnzbd']
}
