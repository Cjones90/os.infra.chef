name 'redis_server'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures redis_server'
long_description 'Installs/Configures redis_server'
version '0.2.10'

chef_version '>= 14.10' if respond_to?(:chef_version)

depends 'trusty'
# depends 'redis', '~> 0'  - Find redis cookbook

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/redis_server/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/redis_server'
