#
# Cookbook:: redis_server
# Recipe:: install
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package "tcl8.5"

redis_version = "5.0.9"

remote_file "/tmp/redis-#{redis_version}.tar.gz" do
    source "http://download.redis.io/releases/redis-#{redis_version}.tar.gz"
    notifies :run, 'execute[unpack-redis]', :immediately
end

execute "unpack-redis" do
    command "cd /tmp; mkdir -p /var/lib/redis; tar xzf redis-#{redis_version}.tar.gz -C /var/lib/redis"
    action :nothing
    notifies :run, 'execute[make-redis]', :immediately
end

execute "make-redis" do
    command "cd /var/lib/redis/redis-#{redis_version}; make clean && make"
    action :nothing
    notifies :run, 'execute[install-redis]', :immediately
end

execute "install-redis" do
    command "cd /var/lib/redis/redis-#{redis_version}; make install"
    action :nothing
    notifies :run, 'execute[edit-redis-conf]', :immediately
end

execute "edit-redis-conf" do
    command "sed -i 's/bind 127\.0\.0\.1/bind 0\.0\.0\.0/' /var/lib/redis/redis-#{redis_version}/redis.conf;
    sed -i 's/protected-mode yes/protected-mode no/' /var/lib/redis/redis-#{redis_version}/redis.conf;"
    action :nothing
    notifies :run, 'execute[run-redis]', :immediately
end

### NOTE: The spaces between the lines in the below resource are intentional
###  as multiple questions are asked when running the install script
execute "run-redis" do
    command "cd /var/lib/redis/redis-#{redis_version}/utils;
./install_server.sh <<-EOF

/var/lib/redis/redis.conf

/var/lib/redis


EOF
sudo update-rc.d redis_6379 defaults;
sudo service redis_6379 start;"
    action :nothing
end
