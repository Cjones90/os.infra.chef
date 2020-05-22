name 'trusty'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures trusty'
long_description 'Installs/Configures trusty'
version '0.13.13'

chef_version '>= 14.10' if respond_to?(:chef_version)

depends 'firewall', '~> 2.6.1'
depends 'chef-client', '~> 8.1.2'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/trusty/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/trusty'