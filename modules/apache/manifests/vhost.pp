define apache::vhost (
  $docroot,
  $port = '80',
  $priority = '10',
  $options = 'Indexes MultiViews',
  $vhost_name = $name,
  $servername = $name,
  $logdir = '/var/log/httpd'
) {
  file { "/etc/httpd/conf.d/${name}.conf":
    ensure  => present,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
    content => template('apache/vhost.conf.erb')
  }
  file { "ensure docroot exists ${docroot}":
    ensure => directory,
    name   => $docroot
  }
  file { "create default page for ${name}":
    ensure  => file,
    name    => "${docroot}/index.html",
    content => "<html><body>Hi, I'm ${name}.</body></html>"
  }
  host { $name:
    ensure => present,
    ip     => '127.0.0.1'
  }
}
