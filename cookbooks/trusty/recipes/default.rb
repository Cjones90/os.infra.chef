#
# Cookbook:: trusty
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


require 'json'

# firewall 'default' do
#     action :install
# end
#
# firewall_rule 'ssh' do
#     port 22
#     protocol :tcp
# end


#### TODO: This is where we come up with a better solution
# ips_json = JSON.parse(::File::read("/root/code/access/ips.json"))
#
# ips_json['station_ips'].each do |ipObj|
#     ipObj.each do |tag, ip|
#         firewall_rule "allow #{tag}" do
#             source ip
#         end
#     end
# end


#### Consul
# managers = search(:node, 'role:manager')
# webs = search(:node, 'role:web')
# builds = search(:node, 'role:build')
# mongos = search(:node, 'role:db_mongo')
# pgs = search(:node, 'role:db_pg')
# redis = search(:node, 'role:db_redis')
# dbs = search(:node, 'role:db')
# admin = search(:node, 'role:admin')
# nodes = managers + webs + builds + mongos + pgs + redis + dbs + admin
#
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
#         port [8600, 8500, 8400, 8301, 8302, 8300]
#         protocol :tcp
#     end
# end



#### SSH/Access
ssh_keys_string = ""
ssh_keys_json = JSON.parse(::File::read("/root/code/access/sshkeys.json"))

ssh_keys_json.each do |key_name, key|
    if key != ""
        ssh_keys_string = ssh_keys_string + key + "\n"
    end
end

file "/root/.ssh/authorized_keys" do
    content ssh_keys_string
end
