class users {
  user { 'fundamentals':
    ensure => present,
    shell  => '/bin/bash',
    groups => 'staff'
  }

  group { 'staff':
    ensure => present
  }
}
