#
# kitchen tests for the sssd cookbook
#

control "sssd - #{os.name} #{os.release} - 01" do
  title 'Ensure required packages are installed'
  packages = %w(sssd)
  packages.each do |package_name|
    describe package(package_name) do
      it { should be_installed }
    end
  end
end

control "sssd - #{os.name} #{os.release} - 02" do
  title 'Ensure configuration has been properly defined'
  lines = [
    'dyndns_refresh_interval = 30',
    'use_fully_qualified_names = False',
    'entry_cache_group_timeout = 200',
    ', corp.dazzlingwrench.internal',
    'domain/corp.dazzlingwrench.internal',
    'id_provider = ad',
    'max_id = 0',
    'enumerate = False',
    'services = nss, pam',
  ]
  lines.each do |line|
    describe file('/etc/sssd/sssd.conf') do
      its('content') { should match(/#{line}/) }
    end
  end
end
