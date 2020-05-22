#
# Cookbook:: nodeapp
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'json'

include_recipe 'trusty::default'
include_recipe 'node::ssl'

directory "/root/code/jsons" do
    recursive true
end

directory "/root/code/csv" do
    recursive true
end


##### Firewall #####
firewall_rule 'http/https/docker' do
    port [80, 443, 2377, 7946]
    protocol :tcp
end

firewall_rule 'docker udp' do
    port [7946, 4789]
    protocol :udp
end

ips_json = JSON.parse(::File::read("/root/code/access/ips.json"))

ips_json['docker_subnets'].each do |ip|
    firewall_rule "Allow from #{ip}" do
        source ip
    end
end
