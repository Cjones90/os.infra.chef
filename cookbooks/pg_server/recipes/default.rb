#
# Cookbook:: pg_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'json'

pg_pass = data_bag_item("secrets", "pg")

# How md5 hash for connection info created:
# https://stackoverflow.com/questions/55278977/how-to-connect-to-postgresql-server-using-encrypted-password
node.override['postgresql']['password']['postgres'] = "#{pg_pass['pass']}"


include_recipe 'trusty::default'
include_recipe 'postgresql::server'
include_recipe 'postgresql::default'


##### Firewall #####
ips_json = JSON.parse(::File::read("/root/code/access/ips.json"))

ips_json['app_ips'].each do |ipObj|
    ipObj.each do |tag, ip|
        firewall_rule "allow #{tag}" do
            source ip
            port 5432
            protocol :tcp
        end
    end
end


managers = search(:node, 'role:manager')
webs = search(:node, 'role:web')
pgs = search(:node, 'role:db_pg')
dbs = search(:node, 'role:db')
nodes = managers + webs + pgs + dbs

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
        port 5432
        protocol :tcp
    end
end
