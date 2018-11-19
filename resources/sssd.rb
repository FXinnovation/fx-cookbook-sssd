#
# cookbook::sssd
# resource::sssd
#
# author::fxinnovation
# description::Resource that allows you to install and configure sssd
#

resource_name :sssd

provides :sssd, platform_family: 'rhel'

property :version,         String
property :configuration,   Hash,          default: {}
property :restart_service, [true, false], default: true

default_action :install

action :install do
  package 'sssd' do
    version new_resource.version if new_resource.property_is_set?('version')
    action  :install
  end
end

action :configure do
  # Define sane default sections
  default_sssd_section = {
    'domains'             => node['domain'],
    'config_file_version' => '2',
    'services'            => 'nss, pam',
  }

  default_domain_section = {
    'ad_domain'                      => node['domain'],
    'krb5_realm'                     => node['domain'].upcase,
    'realmd_tags'                    => 'manages-system joined-with-samba',
    'cache_credentials'              => 'False',
    'id_provider'                    => 'ad',
    'krb5_store_password_if_offline' => 'False',
    'default_shell'                  => '/bin/bash',
    'ldap_id_mapping'                => 'True',
    'use_fully_qualified_names'      => 'True',
    'fallback_homedir'               => '/home/%u@%d',
    'access_provider'                => 'ad',
    'dyndns_update'                  => 'True',
    'dyndns_refresh_interval'        => '60',
    'min_id'                         => '1',
    'max_id'                         => '0',
    'enumerate'                      => 'False',
    'force_timeout'                  => '60',
    'entry_cache_timeout'            => '30',
    'account_cache_expiration'       => '5',
    'pwd_expiration_warning'         => '7',
    'lookup_family_order'            => 'ipv4_first',
    'dns_resolver_timeout'           => '5',
  }

  configuration = {
    'sssd'                     => default_sssd_section,
    "domain/#{node['domain']}" => default_domain_section,
  }

  new_resource.configuration.each do |key, value|
    configuration[key] = case key
                         when 'sssd'
                           default_sssd_section.merge(value)
                         when %r{^domain/.*}
                           default_domain_section.merge(value)
                         else
                           value
                         end
  end

  service 'sssd' do
    action :nothing
  end

  template '/etc/sssd/sssd.conf' do
    source   'sssd.conf.erb'
    mode     '0600'
    owner    'root'
    group    'root'
    notifies :restart, 'service[sssd]', :delayed if new_resource.restart_service
    variables(
      configuration: configuration
    )
    action :create
  end
end
