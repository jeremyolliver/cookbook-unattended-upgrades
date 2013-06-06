require File.expand_path('../support/helpers', __FILE__)

describe_recipe 'unattended-upgrades::default' do

  include Helpers::Unattended_upgrades

  describe 'packages' do
    it 'installs unattended-upgrades' do
      package("unattended-upgrades").must_be_installed
    end
    it 'installs mailutils' do
      package("mailutils").must_be_installed
    end
  end

  describe 'files' do
    let(:config) { file("/etc/apt/apt.conf.d/50unattended-upgrades") }

    it 'should have correct file permissions' do
      config.must_have(:mode, "644")
    end
    it 'should have correct owner' do
      config.must_have(:owner, "root")
    end
    it 'should have correct group' do
      config.must_have(:group, "root")
    end

    it 'should contain the correct config' do
      config.must_include "Unattended-Upgrade::Mail \"#{node['unattended-upgrades']['admin_email']}\";"
    end

    it 'should contain the security updates origin' do
      # Although this test may fail on a setup with minitest-handler running on a live server - security updates really shouldn't be turned off
      config.must_include '"${distro_id}:${distro_codename}-security";'
    end
  end

end
