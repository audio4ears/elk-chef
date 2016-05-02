#
# Cookbook Name:: elk-chef
# Recipe:: elasticsearch_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# set package source url
case node['platform_family']
when 'debian'
  source_url = "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/#{node['elasticsearch']['version']}/elasticsearch-#{node['elasticsearch']['version']}.deb"
when 'rhel'
  source_url = "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/#{node['elasticsearch']['version']}/elasticsearch-#{node['elasticsearch']['version']}.rpm"
end

# download elasticsearch
remote_file 'download_elasticsearch' do
  source source_url
  path "/usr/local/src/#{source_url.split('/')[-1]}"
  owner 'root'
  group 'root'
  mode '744'
  action :create_if_missing
end

# install elasticsearch
package 'install_elasticsearch' do
  package_name 'elasticsearch'
  source "/usr/local/src/#{source_url.split('/')[-1]}"
  action :install
end

# start elasticsearch
service 'elasticsearch' do
  action [ :enable, :start ]
end
