# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include qbittorrent_nox::config
class qbittorrent_nox::config (
  Integer $filelogger_age,
  Integer $filelogger_age_type,
  Boolean $filelogger_backup,
  Boolean $filelogger_delete_old,
  Boolean $filelogger_enabled,
  Integer $filelogger_max_size_bytes,
  String  $filelogger_path,
  String  $session_default_save_path,
  String  $session_exclude_file_names,
  Integer $session_max_active_downlaods,
  Integer $session_max_active_torrents,
  Integer $session_max_active_uploads,
  Integer $session_port,
  Boolean $session_queueing_system_enabled,
  String  $auto_delete_added_torrent_file,
  Boolean $legal_notice_accepted,
  Integer $meta_migration_version,
  String  $general_locale,
  Boolean $mail_notification_req_auth,
  String  $webui_auth_subnet_whitelist,
  String  $password,
  String  $password_salt,
  Boolean $auto_downloader_download_repacks,
  String  $auto_downloader_smart_episode_filter,
) {
  $webui_password_pbkdf2 = str2saltedpbkdf2($password, $password_salt, 50000)

  file { $filelogger_path:
    ensure => 'directory',
    owner  => $qbittorrent_nox::system_user,
  }

  file { "/home/${qbittorrent_nox::system_user}/.config/qBittorrent/qBittorrent.conf":
    ensure  => 'file',
    owner   => $qbittorrent_nox::system_user,
    content => epp('qbittorrent_nox/qBittorrent.conf.epp', {
        'password'  => "@ByteArray(${webui_password_pbkdf2['salt_hex']}:${webui_password_pbkdf2['password_hex']}",
    }),
  }
}
