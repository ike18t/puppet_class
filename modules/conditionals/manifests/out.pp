class conditionals::out {
  $os_type = $::osfamily ? {
    'debian' => 'this is debian',
    'redhat' => 'this is redhat',
    'gentoo' => 'this is gentoo',
    default  => 'not sure what you are using'
  }

  file { '/tmp/os':
    ensure  => file,
    content => $os_type
  }
}
