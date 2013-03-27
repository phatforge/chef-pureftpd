#
# Cookbook Name:: pureftpd
# Recipe:: default
#
# Copyright (C) 2013 Pritesh Mehta
#
# All rights reserved - Do Not Redistribute
#



node['pureftpd']['packages'].each do |pkg|
  package pkg do
    action :install
    notifies :start, "service['pure-ftpd']"
  end
end

service node['pureftpd']['service'] do
  supports status: true, restart: true
  action [ :enable, :start ]
end

template '/etc/default/pure-ftpd-common' do
  source 'pure-ftpd-common.erb'
  owner  node['pureftpd']['owner']
  group  node['pureftpd']['owner']
  mode   0644
end

#include_recipe 'pureftpd::logrotate'
