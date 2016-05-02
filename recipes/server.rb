#
# Cookbook Name:: elk-chef
# Recipe:: server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe "#{cookbook_name}::java"
include_recipe "#{cookbook_name}::elasticsearch"
include_recipe "#{cookbook_name}::logstash"
include_recipe "#{cookbook_name}::kibana"
