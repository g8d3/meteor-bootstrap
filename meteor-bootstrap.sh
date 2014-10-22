#!/bin/bash

app_name=$1
script_dir="$(cd "$(dirname "$0")" && pwd)"

if [ -z $app_name ]; then
  echo please provide an application name:
  echo ./meteor_bootstrap.sh my-app-name
else
  echo() { builtin echo && builtin echo "==>" "$@"; }

  echo Creating Meteor application...
  meteor create $app_name
  cd $app_name

  echo Installing Meteor packages...
  packages=(coffeescript mquandalle:jade stylus accounts-base accounts-password
    accounts-ui iron:router houston:admin bootstrap)
  meteor add ${packages[@]}
  # for package in ${packages[@]}; do
  #   mrt add $package > /dev/null
  # done

  echo Setting up basic folder structure...
  rm $app_name.html
  rm $app_name.js
  rm $app_name.css
  mkdir public
  mkdir -p client/templates
  mkdir server
  mkdir common

  render_template(){
    eval "builtin echo \"$(cat $1)\""
  }

  echo Copying basic templates...
  render_template ${script_dir}/templates/router.coffee > common/router.coffee
  render_template ${script_dir}/templates/layout.jade > client/templates/layout.jade

  mkdir -p client/templates/home
  render_template ${script_dir}/templates/home.jade > client/templates/home/home.jade

  echo Adding git versioning...
  git init . > /dev/null
  git add . > /dev/null
  git commit -m 'Initial commit.' > /dev/null

  echo Done! you can cd into $app_name
fi
