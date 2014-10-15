# Install PHP

class php5::install {

	package { [
	  'php5',
	  'php5-mysql',
	  'php5-curl',
	  'php5-gd',
	  'php5-fpm',
	  'libapache2-mod-php5',
	  'php5-dev',
	  'php5-xdebug',
	  'php-pear',
	]:
	ensure => present,
	}

	# upgrade pear
	exec {"pear upgrade":
	  command => "/usr/bin/pear upgrade",
	  require => Package['php-pear'],
	}

	# set channels to auto discover
	exec { "pear auto_discover" :
		command => "/usr/bin/pear config-set auto_discover 1",
		require => [Package['php-pear']]
	}

	# update channels
	exec { "pear update-channels" :
		command => "/usr/bin/pear update-channels",
		require => [Package['php-pear']]
	}

  # Turn on short open tags in php since WPEngine code uses them.
  file { '/etc/php5/apache2/php.ini':
    require => Package['phpmyadmin'],
    ensure => present,
  }
  file_line { 'Append a line to /etc/php5/apache2/php.ini':
    require => Package['phpmyadmin'],
    path => '/etc/php5/apache2/php.ini',
    line => 'short_open_tag = On',
    match => "^short_open_tag.*$",
  }

}
