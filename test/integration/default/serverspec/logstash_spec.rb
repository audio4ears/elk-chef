require 'spec_helper'

describe 'elk-chef::logstash' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # logstash tests
  describe package('logstash') do
    it { should be_installed }
  end

  describe service('logstash') do
    it { should be_enabled }
  end

  describe service('logstash') do
    it { should be_running }
  end
end
