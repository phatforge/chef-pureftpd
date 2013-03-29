#
# Cookbook Name:: pureftpd
# Recipe:: authd
#
# Copyright (C) 2013 Pritesh Mehta
#
# All rights reserved - Do Not Redistribute
#


if node['pureftpd']['authd']['enable']

  node.set['pureftpd']['service'] = "pure-ftpd-authd"

  template "#{node['pureftpd']['authd']['service_dir']}/pure-ftpd-authd" do
    source   "pure-ftpd-authd.init.d.erb"
    owner    node['pureftpd']['owner']
    group    node['pureftpd']['group']
    mode     0755
  end

  service node['pureftpd']['service'] do
    supports status: true, restart: true
    action [ :enable, :start ]
  end

  include_recipe 'pureftpd::default'

  file "#{node['pureftpd']['base_config_dir']}/conf/ExtAuth" do
    owner    node['pureftpd']['owner']
    group    node['pureftpd']['group']
    mode     0755
    content  node['pureftpd']['authd']['sock_path']
    not_if { ::File.exists?("#{node['pureftpd']['base_config_dir']}/conf/ExtAuth")}
  end

  link  "#{node['pureftpd']['base_config_dir']}/auth/60extauth" do
    to "#{node['pureftpd']['base_config_dir']}/conf/ExtAuth"
  end

else
  Chef::Log.warn "Pure Ftpd Authd not enabled - Skipping this recipe"
end

