include apache

apache::vhost { 'elmo.puppetlabs.net':
  docroot => '/var/www/elmo',
  options => 'Indexes MultiViews',
  notify  => Service['httpd']
}

apache::vhost { 'piggy.puppetlabs.net':
  docroot => '/var/www/piggy',
  options => '-MultiViews',
  notify  => Service['httpd']
}
