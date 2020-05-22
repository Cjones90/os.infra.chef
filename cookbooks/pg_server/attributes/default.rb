# default['postgresql']['version'] = '9.4'
# default['postgresql']['dir'] = '/etc/postgresql/9.4/main'
# default['postgresql']['server']['service_name'] = 'postgresql'
# default['postgresql']['client']['packages'] = ['postgresql-client-9.4', 'libpq-dev']
# default['postgresql']['server']['packages'] = ['postgresql-9.4']
# default['postgresql']['contrib']['packages'] = ['postgresql-contrib-9.4']

default['postgresql']['config']['listen_addresses'] = '*'
# default['postgresql']['password']['postgres'] = ""

# Example hash
# [{:comment => '# Optional comment',
# :type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'md5'}]

# Already configed defaults
#  default['postgresql']['pg_hba'] = [
# { type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'ident' },
# { type: 'local', db: 'all', user: 'all', addr: nil, method: 'ident' },
# { type: 'host', db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'md5' },
# { type: 'host', db: 'all', user: 'all', addr: '::1/128', method: 'md5' }
# ]

default['postgresql']['pg_hba'][0] = {
    type: 'host', db: 'all', user: 'all', addr: '0.0.0.0/0', method: 'md5'
}

default['postgresql']['pg_hba'][1] = {
    type: 'local', db: 'all', user: 'all', addr: '', method: 'trust'
}
