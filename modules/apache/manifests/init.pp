class apache {
  package { 'httpd_package':
    ensure => installed,
    name   => 'httpd'
  }

  service { 'httpd_service':
    ensure  => running,
    name    => 'httpd',
    require => 'Package[httpd]'
  }

  file { '/etc/httpd/conf/httpd.conf':
    ensure  => file,
    source  => 'puppet:///modules/apache/httpd.conf',
    notify  => 'Service[httpd_service]'
  }

  file {['/var/www', '/var/www/html']:
    ensure  => directory
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    source  => 'puppet:///modules/apache/index.html'
  }
}
