#!/usr/bin/env bash

cd .
#. ~/.rvm/scripts/rvm
git add -A
git commit -m "$1"
git push
#bundle exec rake build
rake build
mv pkg/gitlab_ci-0.*.gem ../repo/gems/
cd ../repo
gem generate_index .
gcp hd-build

gsutil rsync -d -r ./ gs://gems.build.olt.homedepot.com/
gsutil acl ch -r -u All:READ  gs://gems.build.olt.homedepot.com

cd -
