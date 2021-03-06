package {['apache2', 'libapache2-mod-wsgi', 'python-psycopg2',
          'bzr', 'python-pip']:
  provider => apt,
  ensure   => installed,
}

file { "/srv/":
  ensure => directory,
}

vcsrepo { "/srv/$::service_hostname/":
  ensure => present,
  provider => $::app_source_type,
  source   => $::app_source,
  revision => $::app_source_revision,
  require => File["/srv/"],
}

#file { "/srv/$::service_hostname/project/":
#  recurse => true,
#  source => "file:///home/ubuntu/django-app-branch/$::app_source_project_location",
#  require => File["/srv/$::service_hostname/"],
#}

file { "/srv/$::service_hostname/www/":
  ensure => directory,
}

file { "/srv/$::service_hostname/www/root/":
  ensure => directory,
}

file { "/srv/$::service_hostname/www/root/favicon.ico":
  source => "$::charm_dir/files/favicon.ico",
  require => File["/srv/$::service_hostname/www/root/"],
}

file { "/srv/$::service_hostname/www/root/robots.txt":
  source => "$::charm_dir/files/robots.txt",
  require => File["/srv/$::service_hostname/www/root/"],
}

# Eventually this shouldn't be needed if we modularize
# the puppet config (as the module's /templates directory will also
# be checked). In the mean-time, ensure our templates are available.
file { "/etc/puppet/templates/apache-django-wsgi":
  ensure => link,
  target => "$::charm_dir/templates",
}
