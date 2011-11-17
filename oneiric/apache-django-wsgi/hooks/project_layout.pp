file { "/srv/$::service_hostname/__init__.py":
  ensure => present,
}

file { "/srv/$::service_hostname/urls.py":
  content => template("apache-django-wsgi/urls.py.erb"),
}
