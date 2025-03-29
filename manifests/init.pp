# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include qbittorrent_nox
class qbittorrent_nox (
  Enum['present', 'absent'] $ensure = 'present',
  String  $system_user = 'qbittorrent',
) {
  package { 'epel-release':
    ensure => $ensure,
  }

  package { 'qbittorrent-nox':
    ensure  => $ensure,
    require => Package['epel-release'],
  }

  user { 'qbittorrent':
    ensure => $ensure,
  }

  file { "/home/${system_user}/.config/":
    ensure => 'directory',
  }

  file { "/home/${system_user}/.config/qBittorrent":
    ensure  => 'directory',
    require => File["/home/${system_user}/.config/"],
  }
}
