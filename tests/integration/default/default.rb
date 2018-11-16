#
# kitchen tests for the sssd cookbook
#

control "sssd - #{os.name} #{is.release} - 01" do
  title 'Ensure required packages are installed'
  packages = %w(sssd)
  packages.each do |package_name|
    describe(package_name) do
      it { should be_installed }
    end
  end
end
