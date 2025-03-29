# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include qbittorrent_nox::service
class qbittorrent_nox::service (
  Enum['running', 'stopped', 'false', 'true'] $ensure,
  String $description,
  String $after,
  String $exec_start,
  String $type,
  String $restart,
  String $wanted_by,
  String $required_by,
) {
  file { '/etc/systemd/system/qbittorrent.service':
    ensure  => 'file',
    content => epp('qbittorrent_nox/qbittorrent.service.epp'),
  }

  service { 'qbittorrent.service':
    ensure => $ensure,
  }
}
