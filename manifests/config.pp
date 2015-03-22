# == Class sabnzbd::config
#
# This class is called from sabnzbd for service config.
#
class sabnzbd::config (
  $file  = {},
  $home  = undef,
  $user  = undef,
  $group = undef,
) {
  validate_hash($file)
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  $pathname = $file['path']
  $basename = $file['file']
  $target = "${pathname}/${basename}"
  if has_key($file, 'source') {
    file { $target: source => $file['source'], }
  } elsif has_key($file, 'template') {
    file { $target: content => template($file['template']), }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}
