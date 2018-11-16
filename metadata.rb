name             'sssd'
license          'MIT'
maintainer       'FXinnovation'
maintainer_email 'cloudsquad@fxinnovation.com'
description      'Cookbook that helps you handle and maintain SSSD on Linux Servers'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
chef_version     '>= 12.14' if respond_to?(:chef_version)
issues_url       'https://bitbucket.org/fxadmin/public-common-cookbook-sssd/issues'
source_url       'https://bitbucket.org/fxadmin/public-common-cookbook-sssd'
supports         'redhat',  '>= 7.0'
supports         'centos',  '>= 7.0'
