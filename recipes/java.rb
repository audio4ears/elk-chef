#
# Cookbook Name:: elk-chef
# Recipe:: java
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install packages(s)
package [ "#{node['java']['package']}" ]

# add binaries to PATH
config = {
  'export JAVA_HOME' => node['java']['java_home'],
  'export PATH' => '$JAVA_HOME/bin:$PATH'
}

bash 'source_java_envs' do
  code 'source /etc/profile.d/java.sh'
  action :nothing
end

template 'set_java_envs' do
  source 'properties.erb'
  path '/etc/profile.d/java.sh'
  variables config: config
  owner 'root'
  group 'root'
  mode '644'
  notifies :run, 'bash[source_java_envs]', :immediately
end
