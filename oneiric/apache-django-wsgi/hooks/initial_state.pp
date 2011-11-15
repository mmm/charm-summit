package {'apache2':
  provider => apt,
  ensure   => installed,
}

package {'libapache2-mod-wsgi':
  provider => apt,
  ensure   => installed,
}

package {'python-psycopg2':
  provider => apt,
  ensure   => installed,
}

file { "/srv/":
  ensure => directory,
}

file { "/srv/$::hostname/":
  ensure => directory,
}
