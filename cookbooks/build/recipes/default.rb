#
# Cookbook:: build
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'json'

include_recipe 'trusty::default'


###### Firewall - Only does docker? TODO: Do this better #####
ips_json = JSON.parse(::File::read("/root/code/access/ips.json"))

ips_json['docker_subnets'].each do |ip|
    firewall_rule "Allow from #{ip}" do
        source ip
    end
end
