#
# Cookbook:: mongo_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'json'


include_recipe 'trusty::default'
include_recipe "sc-mongodb::default"


##### Firewall #####
ips_json = JSON.parse(::File::read("/root/code/access/ips.json"))

ips_json['app_ips'].each do |ipObj|
    ipObj.each do |tag, ip|
        firewall_rule "allow #{tag}" do
            source ip
            port 27017
            protocol :tcp
        end
    end
end

managers = search(:node, 'role:manager')
webs = search(:node, 'role:web')
mongos = search(:node, 'role:db_mongo')
dbs = search(:node, 'role:db')
nodes = managers + webs + mongos + dbs

nodes.each do |node|
    ip = ""
    if node.attribute?('ec2')
        ip = node['ec2']['public_ipv4']
    else
        # t3a ec2 instance had the inet interface at ens5 instead of eth0
        ip = node[:network][:interfaces][:eth0]['addresses'].detect{|k,v| v[:family] == 'inet'}.first
    end
    firewall_rule "Allow from #{ip}" do
        source ip
        port 27017
        protocol :tcp
    end
end
