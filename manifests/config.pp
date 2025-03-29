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
  $salt = SecureRandom.uuid
  $password_bytes = $plaintext_password.encode('UTF-8')
  $salt_bytes = $salt.bytes

  $iterations = 100000
  $dklen = 64
  $hashed_password = inline_template('<%= OpenSSL::PKCS5.pbkdf2_hmac($password_bytes, $salt_bytes, $iterations, $dklen, "sha512").unpack("H*").first %>')

  $b64_salt = Base64.encode64($salt_bytes.pack('C*')).strip
  $b64_password = Base64.encode64([$hashed_password].pack('H*')).strip

  $password_string = "@ByteArray(${b64_salt}:${b64_password})"

  file { $filelogger_path:
    ensure => 'directory',
    owner  => $qbittorrent_nox::system_user,
  }

  file { "/home/${qbittorrent_nox::system_user}/.config/qBittorrent/qBittorrent.conf":
    ensure  => 'file',
    owner   => $qbittorrent_nox::system_user,
    content => epp('qbittorrent_nox/qBittorrent.conf.epp', {
        'password'  => $password_string,
    }),
  }
}
