
app_name=$1

if [ -z $app_name ]; then
  echo please provide an application name:
  echo . ./mrt_bootstrap.sh my-app-name
else

  mrt create $app_name
  cd $app_name
  mrt add coffeescript
  mrt add jade
  mrt add stylus
  mrt add accounts-base
  mrt add accounts-password
  mrt add accounts-ui
  mrt add iron-router
  mrt add houston
  mrt add semantic-ui
  rm $app_name.html
  rm $app_name.js
  rm $app_name.css
  mkdir public
  mkdir -p client/templates
  mkdir server
  mkdir common

fi
