#!/bin/bash

generate_ssh_keys() {
  local user=$1
  local home=$2
  if [ ! -f $home/.ssh/id_rsa ]; then
    su -l $user -c "ssh-keygen -q -N '' -t rsa -b 2048 -f $home/.ssh/id_rsa"
  fi
}

pip_install() {
  local requirements=$1
  pip install -r $requirements
}


#MMM idempotency?
summit_configure() {
  local project_dir=$1

  pip_install "$project_dir/requirements.txt"

  # db should be here for the rest of this

  # template local_settings.py
  cp local_settings.py.sample local_settings.py

  generate_ssh_keys ubuntu /home/ubuntu # goes away when bzr+ssh: changes to http:

  #./manage.py init-summit

  #./manage.py pullapps

  #./manage.py syncdb

  #./manage.py migrate

}

summit_run() {
  local project_dir=$1

  # template a real upstart job here
  #cd $project_dir && ./manage.py runserver

}

