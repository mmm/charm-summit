# TODO: add conditional for non-configglue settings.
file { "/srv/$::service_hostname/project/local.cfg":
  content => template("apache-django-wsgi/local.cfg.erb"),
}

exec { "python ./manage.py syncdb --noinput":
  cwd => "/srv/$::service_hostname/project",
  path => ["/usr/bin"],
  require => File["/srv/$::service_hostname/project/local.cfg"],
}
exec { "python ./manage.py migrate":
  cwd => "/srv/$::service_hostname/project",
  path => ["/usr/bin"],
  require => Exec["python ./manage.py syncdb --noinput"],
}

# Only after we're certain that all required apps/packages are installed
# do we collect all the static files ready for apache to serve.
exec { "python ./manage.py collectstatic --noinput":
  cwd => "/srv/$::service_hostname/project",
  path => ["/usr/bin"],
  require => File["/srv/$::service_hostname/project/local.cfg"],
}
