#
# Cookbook Name:: pureftpd
# Recipe:: logrotate
#
# Copyright (C) 2013 Pritesh Mehta
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'pureftpd::default'

directory node['pureftpd']['logrotate']['config_dir'] do
  owner  node['pureftpd']['owner']
  group  node['pureftpd']['group']
  mode   0755
  not_if { ::File.exists?(node['pureftpd']['logrotate']['config_dir'])}
end

Chef::Log.warn node.pureftpd.logrotate.config

template "#{node['pureftpd']['logrotate']['config']}" do
  source    "pure-ftpd-common.logrotate.erb"
  owner     node['pureftpd']['owner']
  group     node['pureftpd']['group']
  mode      0644
  variables( :log_settings => node['pureftpd']['logrotate'] )
end
