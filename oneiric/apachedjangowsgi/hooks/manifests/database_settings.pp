# TODO: add conditional for non-configglue settings.
file { "/srv/$::service_hostname/project/local.cfg":
  content => template("apache-django-wsgi/local.cfg.erb"),
}

