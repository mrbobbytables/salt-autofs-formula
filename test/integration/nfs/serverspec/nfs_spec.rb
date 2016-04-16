require 'serverspec'
require 'yaml'

set :backend, :exec

pillar_data = YAML.load_file('/tmp/kitchen/srv/pillar/autofs.sls')
nfs = pillar_data['autofs']['lookup']['nfs']


describe 'SLS: autofs.install' do
  describe 'STATE: install-autofs' do
    describe package('autofs') do
      it { should be_installed }
    end
  end
  
  describe 'STATE: install-autofs-prereqs-nfs' do
    case os[:family]
    when 'debian', 'ubuntu'
      describe package('nfs-common') do
        it { should be_installed }
      end
    when 'redhat'
      describe package('nfs-utils') do
        it { should be_installed }
      end
    end
  end
end

describe 'SLS: autofs.config' do 
  describe 'STATE: config-autofs-master' do
    describe file('/etc/auto.master') do
      it { should exist }
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
  end
end


describe 'SLS: autofs.nfs' do
  describe 'STATE: config-autofs-nfs' do
    describe file(nfs['file']) do
      it { should exist }
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
  end
  describe 'RENDER: config-autofs-nfs' do
    describe file(nfs['file']) do
      nfs['map'].each do | item |
        its(:content) { should contain item['mount'] }
        its(:content) { should contain item['options'] }
        its(:content) { should contain item['location'] }
      end
    end
  end
end
