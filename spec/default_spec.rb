require_relative 'spec_helper'

describe 'unattended-upgrades::default' do
  before do
    stub_resources
  end

  describe 'ubuntu' do

    describe 'default attributes' do
      let(:chef_run) { ChefSpec::Runner.new(UBUNTU_OPTS).converge(described_recipe) }

      it 'should install unattended-upgrades' do
        expect(chef_run).to install_package('unattended-upgrades')
        expect(chef_run).to install_package('mailutils')
      end

      it 'should write the config files' do
        expect(chef_run).to render_file('/etc/apt/apt.conf.d/50unattended-upgrades').with_content('Unattended-Upgrade::Mail "root@localhost"')
        expect(chef_run).to render_file('/etc/apt/apt.conf.d/20auto-upgrades').with_content('APT::Periodic::Unattended-Upgrade "1"')
      end
    end

    # TODO: this should pass, but this is about to be refactored
    # describe 'without an email set' do
    #   let(:chef_run) do
    #     ChefSpec::Runner.new(UBUNTU_OPTS) do |node|
    #       node.set['unattended-upgrades']['admin_email'] = nil
    #     end.converge(described_recipe)
    #   end

    #   it 'should not install a mail handler' do
    #     expect(chef_run).to_not install_package('mailutils')
    #   end
    # end
  end

  describe 'debian' do
    let(:chef_run) { ChefSpec::Runner.new(DEBIAN_OPTS).converge(described_recipe) }

    it 'should install unattended-upgrades' do
      expect(chef_run).to install_package('unattended-upgrades')
      expect(chef_run).to install_package('mailutils')
    end

    it 'should write the config files' do
      expect(chef_run).to render_file('/etc/apt/apt.conf.d/50unattended-upgrades').with_content('Unattended-Upgrade::Mail')
      expect(chef_run).to render_file('/etc/apt/apt.conf.d/20auto-upgrades').with_content('APT::Periodic::Unattended-Upgrade "1"')
    end
  end

end
