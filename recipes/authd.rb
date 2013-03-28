#
# Cookbook Name:: pureftpd
# Recipe:: default
#
# Copyright (C) 2013 Pritesh Mehta
#
# All rights reserved - Do Not Redistribute
#


if node['pureftpd']['authd']['enable']
  template "#{node['pureftpd']['authd']['service_dir']}/pure-ftpd-authd" do
    source   "pure-ftpd-authd.init.d.erb"
    owner    node['pureftpd']['owner']
    group    node['pureftpd']['group']
    mode     0755
    not_if { ::File.exists?("#{node['pureftpd']['authd']['service_dir']}/pure-ftpd-authd")}
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
  Chef::Log.warn "Pure Ftpd Authd not specified - Skipping configuration"
end

#node['pureftpd']['packages'].each do |pkg|
  #package pkg do
    #action :install
    #notifies :start, "service[#{node['pureftpd']['service']}]"
  #end
#end


#template '/etc/default/pure-ftpd-common' do
  #source 'pure-ftpd-common.erb'
  #owner  node['pureftpd']['owner']
  #group  node['pureftpd']['group']
  #mode   0644
#end

#directory node['pureftpd']['base_config_dir'] do
  #owner  node['pureftpd']['owner']
  #group  node['pureftpd']['group']
  #mode   0755
  #not_if { ::File.exists?(node['pureftpd']['base_config_dir'])}
#end

#case node['platform']
#when "ubuntu"
  #%w{auth conf db}.each do |conf_dir|
    #directory "#{node['pureftpd']['base_config_dir']}/#{conf_dir}" do
      #owner  node['pureftpd']['owner']
      #group  node['pureftpd']['group']
      #mode   0755
      #not_if { ::File.exists?("#{node['pureftpd']['base_config_dir']}/#{conf_dir}")}
    #end
  #end

  #node['pureftpd']['base'].each do |setting|
    #next if setting.last.nil?
    #settings = setting.last
    #settings.each_pair do |key, value|
      ## if nil then delete the file
      #file "#{node['pureftpd']['base_config_dir']}/#{setting.first}/#{key}" do
        #owner     node['pureftpd']['owner']
        #group     node['pureftpd']['group']
        #mode      0644
        #content   value
        #notifies  :restart, "service[#{node['pureftpd']['service']}]", :delayed
      #end
    #end
  #end
#end

#directory node['pureftpd']['log_dir'] do
  #owner     node['pureftpd']['owner']
  #group     node['pureftpd']['group']
  #mode 0755
  #not_if { ::File.exists?(node['pureftpd']['log_dir'])}
#end

#include_recipe 'pureftpd::logrotate'
