#!/usr/bin/env bash

cd "${0%/*}/../"

# -e  Exit immediately if a simple command exits with a non-zero status
# -x  Print a trace of simple commands and their arguments after they are
# expanded and before they are executed.
set -xe

echo "Test that Console can self install if needed"
rm -R vendor
bin/console about --env=test

echo "Install Composer with dev dependencies"
composer install

phpdbg -qrr -d memory_limit=-1 bin/phpunit --coverage-clover coverage.xml

vendor/bin/phpstan analyse src/ --level=7

vendor/bin/php-cs-fixer fix --config=.php_cs.dist -v --dry-run --stop-on-violation --diff --using-cache=no