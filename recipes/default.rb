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
  group  node['pureftpd']['group']
  mode   0644
end

directory node['pureftpd']['base_config_dir'] do
  owner  node['pureftpd']['owner']
  group  node['pureftpd']['group']
  mode   0755
end

case platform
when "ubuntu"
  %w{auth conf db}.each do |conf_dir|
    directory "#{node['pureftpd']['base_config_dir']}/#{config_dir}" do
      owner  node['pureftpd']['owner']
      group  node['pureftpd']['group']
      mode   0755
    end
  end

  node['pureftpd']['base'].each do |setting_type|
    setting_type.each_pair do |setting, value|
    file "#{node['pureftpd']['base_config_dir']}/#{setting_type.to_s}/#{setting}" do
      owner     node['pureftpd']['owner']
      group     node['pureftpd']['group']
      mode      0755
      contents  value
    end
  end
end

#include_recipe 'pureftpd::logrotate'
