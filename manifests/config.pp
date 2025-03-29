# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include qbittorrent_nox::config
class qbittorrent_nox::config (
  Integer $filelogger_age = 1,
  Integer $filelogger_age_type = 1,
  Boolean $filelogger_backup = true,
  Boolean $filelogger_delete_old = true,
  Boolean $filelogger_enabled = true,
  Integer $filelogger_max_size_bytes = 66560,
  String  $filelogger_path = '/var/log/qbittorrent',
  String  $session_default_save_path = '/downloads',
  String  $session_exclude_file_names = '',
  Integer $session_max_active_downlaods = 5,
  Integer $session_max_active_torrents = 5,
  Integer $session_max_active_uploads = 5,
  Integer $session_port = 55733,
  Boolean $session_queueing_system_enabled = false,
  String  $auto_delete_added_torrent_file = 'Never',
  Boolean $legal_notice_accepted = true,
  Integer $meta_migration_version = 6,
  String  $general_locale = 'en',
  Boolean $mail_notification_req_auth = true,
  String  $webui_auth_subnet_whitelist = '@Invalid()',
  String  $password = 'password',
  Boolean $auto_downloader_download_repacks = true,
  String  $auto_downloader_smart_episode_filter = 's(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-\\d{1,2}[.\\-\\d{1,2})", "(\\d{1,2}[.\\-\\d{1,2}[.\\-\\d{4})"',
) {
  $webui_password_pbkdf2 = str2saltedpbkdf2($password, 'sha512', 4096, 16, 64)

  file { "/home/${qbittorrent_nox::system_user}/.config/qBittorrent/qBittorrent.conf":
    ensure  => 'file',
    owner   => $qbittorrent_nox::system_user,
    content => epp('qbittorrent_nox/qBittorrent.conf.epp', {
        'password'  => $webui_password_pbkdf2,
    }),
  }
}
