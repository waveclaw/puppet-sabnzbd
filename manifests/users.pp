# == Class sabnzbd::users
#
# This class is called from sabnzbd for pre-install user setup.
#
class sabnzbd::users {
  group { $::sabnzbd::group_name:
    ensure => present,
  }

  user { $::sabnzbd::user_name:
    ensure           => present,
    comment          => 'Sabnzbd daemon',
    groups           => $::sabnzbd::group_name,
    home             => $::sabnzbd::user_home,
    password         => '!',
    password_max_age => '-1',
    password_min_age => '-1',
    shell            => '/bin/false',
  }

  Group[ $::sabnzbd::group_name ] ->
  User[ $::sabnzbd::user_name ]
}
