#
# Cookbook Name:: elk-chef
# Recipe:: kibana_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# set package source url
case node['platform_family']
when 'debian'
  source_url = "https://download.elastic.co/kibana/kibana/kibana_#{node['kibana']['version']}_amd64.deb"
when 'rhel'
  source_url = "https://download.elastic.co/kibana/kibana/kibana-#{node['kibana']['version']}-1.x86_64.rpm"
end

# download kibana
remote_file 'download_kibana' do
  source source_url
  path "/usr/local/src/#{source_url.split('/')[-1]}"
  owner 'root'
  group 'root'
  mode '744'
  action :create_if_missing
end

# install kibana
package 'install_kibana' do
  package_name 'kibana'
  source "/usr/local/src/#{source_url.split('/')[-1]}"
  action :install
end

# start kibana
service 'kibana' do
  action [ :enable, :start ]
end
