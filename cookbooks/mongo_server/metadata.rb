name 'mongo_server'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures mongo_server'
long_description 'Installs/Configures mongo_server'
version '0.6.0'

chef_version '>= 14.10' if respond_to?(:chef_version)

depends 'trusty'
# depends 'mongodb3', '~> 5.3.0'
depends 'sc-mongodb', '~> 1.2.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/mongo_server/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/mongo_server'
