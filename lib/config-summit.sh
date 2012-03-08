

generate_ssh_keys() {
  #MMM this goes away when bzr+ssh: changes to http:
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
configure_summit() {
  local project_dir=$1

  generate_ssh_keys ubuntu /home/ubuntu

  pip_install "$project_dir/requirements.txt"

  # db should be here for the rest of this

  # template local_settings.py
  cp local_settings.py.sample local_settings.py

  ./manage.py init-summit
  ./manage.py pullapps

  ./manage.py syncdb
  ./manage.py migrate

}

run_summit() {
  local project_dir=$1

  # template a real upstart job here
  ./manage.py runserver

}

