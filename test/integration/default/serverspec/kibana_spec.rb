require 'spec_helper'

describe 'elk-chef::kibana' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # kibana tests
  describe package('kibana') do
    it { should be_installed }
  end

  describe service('kibana') do
    it { should be_enabled }
  end

  describe service('kibana') do
    it { should be_running }
  end

  describe port(5601) do
    it { should be_listening }
  end
end
