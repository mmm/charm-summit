#!/bin/bash



#MMM idempotency?
summit_configure() {
  local project_dir=$1

  #cd $project_dir && ./manage.py syncdb

  #cd $project_dir && ./manage.py migrate

}

summit_run() {
  local project_dir=$1

  # template a real upstart job here
  #cd $project_dir && ./manage.py runserver

}

