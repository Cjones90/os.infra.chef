#
# Cookbook:: trusty
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

ssh_root = node['node']['default']['ssh_root']

timezone 'America/Los_Angeles'

apt_update 'Update daily' do
    frequency 86_400
    action :periodic
end

package 'build-essential'
package 'apt-utils'
package 'openjdk-8-jdk'
package 'vim'
package 'git'
package 'awscli'

directory ssh_root do
    recursive true
end

directory "/root/code/logs" do
    recursive true
end

directory "/root/code/backups" do
    recursive true
end

directory "/root/code/scripts" do
    recursive true
end

directory "/root/builds" do
    recursive true
end

directory "/root/.tmux/plugins" do
    recursive true
end

git "/root/.tmux/plugins/tpm" do
    repository "https://github.com/tmux-plugins/tpm"
    revision 'master'
    action :sync
end

template "/root/.tmux.conf" do
    source "tmux.conf.erb"
    mode "0755"
    action :create
end

private_key "id_rsa" do
    path "#{ssh_root}/id_rsa"
    action :create
end

public_key "id_rsa.pub" do
    source_key_path "#{ssh_root}/id_rsa"
    path "#{ssh_root}/id_rsa.pub"
    action :create
end

directory "/root/repos" do
    recursive true
end.run_action(:create)


file "/root/.gitconfig" do
    content "[credential]
        helper = store\n"
end


include_recipe 'trusty::ufw'
include_recipe 'trusty::access'
