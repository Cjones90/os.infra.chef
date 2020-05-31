#
# Cookbook:: pg_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

pg_pass = data_bag_item("secrets", "pg")

# How md5 hash for connection info created:
# https://stackoverflow.com/questions/55278977/how-to-connect-to-postgresql-server-using-encrypted-password
node.override['postgresql']['password']['postgres'] = "#{pg_pass['pass']}"


include_recipe 'postgresql::server'
include_recipe 'postgresql::default'
