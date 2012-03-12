# TODO: add conditional for non-configglue settings.
file { "/srv/$::service_hostname/project/local_settings.py":
  content => template("apache-django-wsgi/local_settings.py.erb"),
}

#exec { "python ./manage.py init-summit":
#  cwd => "/srv/$::service_hostname/project",
#  path => ["/usr/bin"],
#  require => File["/srv/$::service_hostname/project/local_settings.py"],
#}
#exec { "python ./manage.py pullapps":
#  cwd => "/srv/$::service_hostname/project",
#  path => ["/usr/bin"],
#  require => Exec["python ./manage.py init-summit"],
#}
#exec { "python ./manage.py syncdb --noinput":
#  cwd => "/srv/$::service_hostname/project",
#  path => ["/usr/bin"],
#  require => Exec["python ./manage.py pullapps"],
#}
#exec { "python ./manage.py migrate":
#  cwd => "/srv/$::service_hostname/project",
#  path => ["/usr/bin"],
#  require => Exec["python ./manage.py syncdb --noinput"],
#}

# Only after we're certain that all required apps/packages are installed
# do we collect all the static files ready for apache to serve.
#exec { "python ./manage.py collectstatic --noinput":
#  cwd => "/srv/$::service_hostname/project",
#  path => ["/usr/bin"],
#  require => File["/srv/$::service_hostname/project/local.cfg"],
#}
