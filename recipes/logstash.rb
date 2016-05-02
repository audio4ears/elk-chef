#
# Cookbook Name:: elk-chef
# Recipe:: logstash_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# set package source url
case node['platform_family']
when 'debian'
  source_url = "https://download.elastic.co/logstash/logstash/packages/debian/logstash_#{node['logstash']['version']}-1_all.deb"
when 'rhel'
  source_url = "https://download.elastic.co/logstash/logstash/packages/centos/logstash-#{node['logstash']['version']}-1.noarch.rpm"
end

# download logstash
remote_file 'download_logstash' do
  source source_url
  path "/usr/local/src/#{source_url.split('/')[-1]}"
  owner 'root'
  group 'root'
  mode '744'
  action :create_if_missing
end

# install logstash
package 'install_logstash' do
  package_name 'logstash'
  source "/usr/local/src/#{source_url.split('/')[-1]}"
  action :install
end

# install logstash plugins
node['logstash']['plugins'].each do |plugin|
  bash "install_logstash_plugin_#{plugin}" do
    cwd '/opt/logstash'
    code "./bin/logstash-plugin install #{plugin}"
    action :run
  end
end unless node['logstash']['plugins'].empty?

# add logstash configs
node['logstash']['configs'].each do |config|
  template "config_logstash_#{config}" do
    source "#{config}.conf.erb"
    path "/etc/logstash/conf.d/#{config}.conf"
    owner 'root'
    group 'root'
    mode '0644'
  end
end unless node['logstash']['configs'].empty?

# start logstash
service 'logstash' do
  case node['platform_family']
  when 'debian'
    service_name 'logstash'
  when 'rhel'
    service_name 'logstash.service'
  end
  action [ :enable, :start ]
end
