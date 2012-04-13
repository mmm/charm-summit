# This can't go in the initial_state.pp as puppet ensures the template is
# available *before* the symlink is added to /etc/puppet/templates (using
# 'require' doesn't affect this).
# Eventually this should be conditional on whether a provided config branch
# already includes a wsgi file.
file { "/srv/$::service_hostname/summit/django.wsgi":
  content => template("apache-django-wsgi/django.wsgi.erb"),
}

file { "/etc/apache2/conf.d/summit.conf":
  content => template("apache-django-wsgi/vhost.conf.erb"),
}

# Using `pip install` together with vcsrepo here as `pip -e ...` to get the
# branch directly won't install it on the system.
#package {"/home/ubuntu/django-app-branch":
#provider => pip,
#ensure   => installed,
#}
