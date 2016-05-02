#
# Cookbook Name:: elk-chef
# Recipe:: filebeat
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# set package source url
case node['platform_family']
when 'debian'
  source_url = "https://download.elastic.co/beats/filebeat/filebeat_#{node['beats']['filebeat']['version']}_amd64.deb"
when 'rhel'
  source_url = "https://download.elastic.co/beats/filebeat/filebeat-#{node['beats']['filebeat']['version']}-x86_64.rpm"
end

# download filebeat
remote_file 'download_filebeat' do
  source source_url
  path "/usr/local/src/#{source_url.split('/')[-1]}"
  owner 'root'
  group 'root'
  mode '744'
  action :create_if_missing
end

# install filebeat
package 'install_filebeat' do
  package_name 'filebeat'
  source "/usr/local/src/#{source_url.split('/')[-1]}"
  action :install
end

# config filebeat
template 'config_filebeat_client' do
  source 'filebeat.yml.erb'
  path '/etc/filebeat/filebeat.yml'
  owner 'root'
  group 'root'
  mode '0644'
end

# start filebeart
service 'filebeat' do
  action [ :enable, :start ]
end
