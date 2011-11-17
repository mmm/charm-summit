# This can't go in the initial_state.pp as puppet ensures the template is
# available *before* the symlink is added to /etc/puppet/templates (using
# 'require' doesn't affect this).
file { "/srv/$::service_hostname/project/django.wsgi":
  content => template("apache-django-wsgi/django.wsgi.erb"),
  require => File["/etc/puppet/templates/apache-django-wsgi"],
}

# Add an alias for our wsgi file to the apache2 conf.

