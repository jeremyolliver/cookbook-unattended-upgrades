require_relative 'spec_helper'

describe 'unattended-upgrades::default' do
  before do
    stub_resources
    stub_command('which mailx').and_return('/usr/bin/mailx')
  end

  describe 'ubuntu' do

    describe 'default attributes' do
      let(:chef_run) { ChefSpec::Runner.new(UBUNTU_OPTS).converge(described_recipe) }

      it 'should install unattended-upgrades' do
        expect(chef_run).to install_package('unattended-upgrades')
      end

      it 'should write the config files' do
        expect(chef_run).to render_file('/etc/apt/apt.conf.d/50unattended-upgrades').with_content('Unattended-Upgrade::Mail "root@localhost"')
        expect(chef_run).to render_file('/etc/apt/apt.conf.d/20auto-upgrades').with_content('APT::Periodic::Unattended-Upgrade "1"')
      end

      it 'should not warn about missing mail package' do
        expect(chef_run).to_not run_ruby_block 'warn-on-missing-mailer'
      end

      describe 'without mailer package' do
        before { stub_command('which mailx').and_return(false) }
        it 'should run warnings' do
          expect(chef_run).to run_ruby_block 'warn-on-missing-mailer'
        end
      end
    end
  end

  describe 'debian' do
    let(:chef_run) { ChefSpec::Runner.new(DEBIAN_OPTS).converge(described_recipe) }

    it 'should install unattended-upgrades' do
      expect(chef_run).to install_package('unattended-upgrades')
    end

    it 'should write the config files' do
      expect(chef_run).to render_file('/etc/apt/apt.conf.d/50unattended-upgrades').with_content('Unattended-Upgrade::Mail')
      expect(chef_run).to render_file('/etc/apt/apt.conf.d/20auto-upgrades').with_content('APT::Periodic::Unattended-Upgrade "1"')
    end
  end

end
