#!/bin/bash
echo "composer global show"
composer global show
cd /repo
echo "codeception: composer show"
composer show
cd /var/www/html
echo "testing code: composer show"
composer show
ls -luha
./yii_test migrate/up --interactive=0
./yii_test rbac/init
codecept run --no-redirect
