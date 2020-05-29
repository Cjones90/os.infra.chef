#
# Cookbook:: redis_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'json'


include_recipe 'trusty::default'
include_recipe 'redis_server::install'


##### Firewall #####
# ips_json = JSON.parse(::File::read("/root/code/access/ips.json"))
#
# ips_json['app_ips'].each do |ipObj|
#     ipObj.each do |tag, ip|
#         firewall_rule "allow #{tag}" do
#             source ip
#             port 6379
#             protocol :tcp
#         end
#     end
# end


# managers = search(:node, 'role:manager')
# webs = search(:node, 'role:web')
# redis = search(:node, 'role:db_redis')
# dbs = search(:node, 'role:db')
# nodes = managers + webs + redis + dbs
#
# nodes.each do |node|
#     ip = ""
#     if node.attribute?('ec2')
#         ip = node['ec2']['public_ipv4']
#     else
#         # t3a ec2 instance had the inet interface at ens5 instead of eth0
#         ip = node[:network][:interfaces][:eth0]['addresses'].detect{|k,v| v[:family] == 'inet'}.first
#     end
#     firewall_rule "Allow from #{ip}" do
#         source ip
#         port 6379
#         protocol :tcp
#     end
# end
