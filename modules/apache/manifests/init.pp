class apache {
  case $::osfamily {
    'debian': {
      $httpd_user = 'www-data'
      $httpd_group = 'www-data'
      $httpd_pkg = 'apache2'
      $httpd_svc = 'apache2'
      $httpd_conf = '/etc/apache2/apache2.conf'
    }
    'redhat': {
      $httpd_user = 'apache'
      $httpd_group = 'apache'
      $httpd_pkg = 'httpd'
      $httpd_svc = 'httpd'
      $httpd_conf = '/etc/httpd/conf/httpd.conf'
    }
    default:
    {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }

  package { 'httpd':
    ensure => installed,
    name   => $httpd_pkg
  }

  service { 'httpd':
    require => Package[httpd],
    ensure  => running,
    name    => $httpd_pkg
  }

  File {
    require => Package[httpd], #adds the apache user and group
    owner   => $httpd_user,
    group   => $httpd_group,
    mode    => '0644'
  }

  file { 'config_file':
    ensure => file,
    path   => $httpd_conf,
    source => "puppet:///modules/apache/${httpd_pkg}.conf",
    notify => Service[httpd]
  }

  file {['/var/www', '/var/www/html']:
    ensure  => directory
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    content => template('apache/index.html.erb')
  }
}
