#
# Cookbook:: node
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# fullchain = data_bag_item("secrets", "fullchain")
# chain = data_bag_item("secrets", "chain")
privkey = data_bag_item("secrets", "privkey")
docker_service = data_bag_item("secrets", "docker_service")

# Containers/servers need to be restarted when we receive a new ssl cert
# Thatll happen rarely as the ssl certs last 3 months and servers _shouldnt_ be up that long
# But it WILL happen...


# file "/etc/ssl/creds/fullchain.pem" do
#     content "#{fullchain["fullchain"].gsub("\\n","\n")}"
#     mode "0755"
#     action :create
# end
#
# file "/etc/ssl/creds/chain.pem" do
#     content "#{chain["chain"].gsub("\\n","\n")}"
#     mode "0755"
#     action :create
# end

file "/etc/ssl/creds/privkey.pem" do
    content "#{privkey["privkey"].gsub("\\n","\n")}"
    mode "0755"
    action :create
    notifies :run, 'execute[restart-service]', :delayed
end

execute 'restart-service' do
    command "docker service ps #{docker_service["name"]} && docker service update #{docker_service["name"]} --force;
exit 0;"
    action :nothing
end
