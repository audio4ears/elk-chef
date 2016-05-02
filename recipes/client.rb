#
# Cookbook Name:: elk-chef
# Recipe:: client
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


node['beats']['install_list'].each do |beat|
  include_recipe "#{cookbook_name}::#{beat}"
end
