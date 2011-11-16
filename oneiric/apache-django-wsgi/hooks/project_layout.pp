file { "/srv/$::service_hostname/__init__.py":
  ensure => present,
}

# Eventually this shouldn't be needed if we modularize
# the puppet config.
file { "/etc/puppet/templates/apache-django-wsgi":
  ensure => link,
  target => "$::charm_dir/hooks/templates",
}

file { "/srv/$::service_hostname/urls.py":
  content => template("apache-django-wsgi/urls.py.erb"),
  require => File["/etc/puppet/templates/apache-django-wsgi"],
}
