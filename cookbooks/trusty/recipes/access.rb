#
# Cookbook:: trusty
# Recipe:: access
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'json'

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
