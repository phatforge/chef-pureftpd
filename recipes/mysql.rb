#
# Cookbook Name:: pureftpd
# Recipe:: default
#
# Copyright (C) 2013 Pritesh Mehta
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'pureftpd::default'

node['pureftpd']['packages'].each do |pkg|
  package pkg do
    action :install
    notifies :start, "service[#{node['pureftpd']['service']}]"
  end
end

service node['pureftpd']['service'] do
  supports status: true, restart: true
  action [ :enable, :start ]
end

Chef::Log.warn node['pureftpd']['mysql']['config']

template node['pureftpd']['mysql']['config'] do
  source   "mysql.conf.erb"
  owner    node['pureftpd']['owner']
  group    node['pureftpd']['group']
  mode     0600
end

file "#{node['pureftpd']['base_config_dir']}/conf/MySQLConfigFile" do
  owner    node['pureftpd']['owner']
  group    node['pureftpd']['group']
  mode     0644
  content  node['pureftpd']['mysql']['config']
end

link "#{node['pureftpd']['base_config_dir']}/auth/30mysql" do
  to "#{node['pureftpd']['base_config_dir']}/conf/MySQLConfigFile"
end

