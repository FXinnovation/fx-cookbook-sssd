#
# cookbook::sssd
# recipe::kitchen
#
# author::fxinnovation
# description::Test recipe for the sssd kitchen, can also be used as an example on how to use the cookbook
#

sssd 'default' do
  restart_service false
  action          [:install, :configure]
  configuration(
    'sssd' => {
      'domains' => "#{node['domain']}, corp.dazzlingwrench.internal",
    },
    "domain/#{node['domain']}" => {
      'dyndns_refresh_interval' => '30',
    },
    'domain/corp.dazzlingwrench.internal' => {
      'dyndns_refresh_interval'   => '30',
      'use_fully_qualified_names' => 'False',
      'entry_cache_group_timeout' => '200',
    }
  )
end
