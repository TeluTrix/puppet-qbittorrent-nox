# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include qbittorrent_nox
class qbittorrent_nox (
  Enum['present', 'absent'] $ensure,
  String  $system_user,
) {
  include qbittorrent_nox::config
  include qbittorrent_nox::service

  package { 'epel-release':
    ensure => $ensure,
  }

  package { 'qbittorrent-nox':
    ensure  => $ensure,
    require => Package['epel-release'],
  }

  user { $system_user:
    ensure => $ensure,
  }

  file { "/home/${system_user}":
    ensure => 'directory',
    owner  => $system_user,
  }

  file { "/home/${system_user}/.config/":
    ensure  => 'directory',
    owner   => $system_user,
    require => File["/home/${system_user}"],
  }

  file { "/home/${system_user}/.config/qBittorrent":
    ensure  => 'directory',
    owner   => $system_user,
    require => File["/home/${system_user}/.config/"],
  }
}
