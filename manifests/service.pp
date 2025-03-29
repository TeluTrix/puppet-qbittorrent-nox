# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include qbittorrent_nox::service
class qbittorrent_nox::service (
  Enum['running', 'stopped', 'false', 'true'] $ensure = 'running',
  String $description = 'qBittorrent Service',
  String $after = 'network.target',
  String $exec_start = '/bin/qbittorrent-nox',
  String $type = 'simple',
  String $restart = 'always',
  String $wanted_by = 'default.target',
  String $required_by = 'network.target',
) {
  file { '/etc/systemd/system/qbittorrent.service':
    ensure  => 'file',
    content => epp('qbittorrent_nox/qbittorrent.service.epp'),
  }

  service { 'qbittorrent.service':
    ensure => $ensure,
  }
}
