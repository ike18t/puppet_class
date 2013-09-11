class conditionals::case {
  case $::osfamily {
    'debian': {
      $message = 'good choice'
    }
    'redhat': {
      $message = 'meh'
    }
    'gentoo': {
      $message = 'whoa'
    }
    default: {
      $message = 'wtf?!?'
    }
  }

  file { '/tmp/os':
    ensure  => file,
    content => "os is ${::osfamily}, ${message}"
  }
}
