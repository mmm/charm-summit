package {['apache2', 'libapache2-mod-wsgi', 'python-psycopg2',
          'bzr', 'python-pip']:
  provider => apt,
  ensure   => installed,
}

vcsrepo {"/home/ubuntu/django-app-branch":
  ensure => present,
  provider => $::app_source_type,
  source   => $::app_source,
  revision => $::app_source_revision,
}
# Using `pip install` together with vcsrepo here as `pip -e ...` to get the
# branch directly won't install it on the system.
package {"/home/ubuntu/django-app-branch":
  provider => pip,
  ensure   => installed,
  require  => Vcsrepo["/home/ubuntu/django-app-branch"],
}

file { "/srv/":
  ensure => directory,
}

file { "/srv/$::service_hostname/":
  ensure => directory,
}

file { "/srv/$::service_hostname/project/":
  recurse => true,
  source => "file:///home/ubuntu/django-app-branch/$::app_source_project_location",
  require => File["/srv/$::service_hostname/"],
}

# Eventually this shouldn't be needed if we modularize
# the puppet config (as the module's /templates directory will also
# be checked). In the mean-time, ensure our templates are available.
file { "/etc/puppet/templates/apache-django-wsgi":
  ensure => link,
  target => "$::charm_dir/hooks/templates",
}
