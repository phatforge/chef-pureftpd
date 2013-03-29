#
# Cookbook Name:: pureftpd
# Recipe:: mysql
#
# Copyright (C) 2013 Pritesh Mehta
#
# All rights reserved - Do Not Redistribute
#

# mysql specific attributes
case node['platform']
when 'ubuntu','debian'
  node.set['pureftpd']['packages']                 = %w{pure-ftpd-mysql}
end

node.set['pureftpd']['service'] = 'pure-ftpd-mysql'

include_recipe 'pureftpd::default'

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

