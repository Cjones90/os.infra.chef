#!/bin/bash

git fetch && git pull;

for BOOK in `dir $PWD/cookbooks`; do
    berks install --berksfile $PWD/cookbooks/$BOOK/Berksfile;
    berks upload --berksfile $PWD/cookbooks/$BOOK/Berksfile;
done

knife data bag from file secrets $PWD/data_bags/secrets

for ROLE in `ls $PWD/roles -p | grep -v /`; do
    knife role from file $PWD/roles/$ROLE;
done
