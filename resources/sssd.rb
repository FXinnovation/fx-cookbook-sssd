#
# cookbook::sssd
# resource::sssd
#
# author::fxinnovation
# description::Resource that allows you to install and configure sssd
#

resource_name :sssd

provides :sssd, platform_family: 'rhel'

property :version, String
#property :configuration, Hash, default: node['sssd']['configuration']

default_action :install

action :install do
  package 'sssd' do
    version new_resource.version if new_resource.property_is_set?('version')
    action  :install
  end
end

#action :configure do
#  service 'sssd' do
#    action :nothing
#  end
#
#  template '/etc/sssd/sssd.conf' do
#    source 'sssd.conf.erb'
#    mode   '0600'
#    owner  'root'
#    group  'root'
#    notifies :restart, 'service[sssd]', :delayed
#    variables(
#      configuration: new_resource.configuration
#    )
#    action :create
#  end
#end
