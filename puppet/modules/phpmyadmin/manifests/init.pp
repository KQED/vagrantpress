# Install phpMyAdmin

class phpmyadmin::install {

  package { 'phpmyadmin':
    ensure => present,
  }

  file { '/etc/apache2/sites-enabled/001-phpmyadmin':
    ensure  => link,
    target  => '/etc/phpmyadmin/apache.conf',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  # Allow phpmyadmin to show phpinfo page
  file { '/etc/phpmyadmin/config.inc.php':
    require => Package['phpmyadmin'],
    ensure => present,
  }
  file_line { 'Append a line to /etc/phpmyadmin/config.inc.php':
    require => Package['phpmyadmin'],
    path => '/etc/phpmyadmin/config.inc.php',
    line => '$cfg["ShowPhpInfo"] = TRUE;',
    ensure => present,
  }
}
