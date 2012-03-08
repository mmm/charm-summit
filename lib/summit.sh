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

  local source_dir="/home/ubuntu/django-app-branch"
  pip_install "$source_dir/requirements.txt"

  # db should be here for the rest of this

  # template local_settings.py
  cp $project_dir/local_settings.py.sample $project_dir/local_settings.py

  #generate_ssh_keys ubuntu /home/ubuntu # goes away when bzr+ssh: changes to http:
  #generate_ssh_keys root /root # goes away when bzr+ssh: changes to http:

  cd $project_dir && ./manage.py init-summit

  cd $project_dir && ./manage.py pullapps

  #cd $project_dir && ./manage.py syncdb

  #cd $project_dir && ./manage.py migrate

}

summit_run() {
  local project_dir=$1

  # template a real upstart job here
  #cd $project_dir && ./manage.py runserver

}

