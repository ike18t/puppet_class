class apache {
  package { 'httpd':
    ensure => installed,
    name   => 'httpd'
  }

  service { 'httpd':
    require => 'Package[httpd]',
    ensure  => running,
    name    => 'httpd'
  }

  File {
    require => 'Package[httpd]', #adds the apache user and group
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644'
  }

  file { 'httpd.conf':
    ensure => file,
    path   => '/etc/httpd/conf/httpd.conf',
    source => 'puppet:///modules/apache/httpd.conf',
    notify => 'Service[httpd]'
  }

  file {['/var/www', '/var/www/html']:
    ensure  => directory
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    source  => 'puppet:///modules/apache/index.html'
  }
}
