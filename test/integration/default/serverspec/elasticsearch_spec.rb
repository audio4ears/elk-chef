require 'spec_helper'

describe 'elk-chef::elasticsearch' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # elasticsearch tests
  describe package('elasticsearch') do
    it { should be_installed }
  end

  describe service('elasticsearch') do
    it { should be_enabled }
  end

  describe service('elasticsearch') do
    it { should be_running }
  end

  describe port(9200) do
    it { should be_listening }
  end
end
