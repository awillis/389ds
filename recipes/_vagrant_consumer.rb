#
# Cookbook Name:: dirsrv
# Recipe:: _vagrant_node_one
#
# Copyright 2013, Alan Willis <alan@amekoshi.com>
#
# All rights reserved - Do Not Redistribute
#

include_recipe "dirsrv"

dirsrv_instance node[:hostname] + '_389' do
  has_cfgdir    true
  cfgdir_addr   '29.29.29.10'
  cfgdir_domain "vagrant"
  cfgdir_ldap_port 389
  credentials  node[:dirsrv][:credentials]
  cfgdir_credentials  node[:dirsrv][:cfgdir_credentials]
  host         node[:fqdn]
  suffix       'o=vagrant'
  action       [ :create, :start ]
end

dirsrv_config "nsslapd-auditlog-logging-enabled" do
  credentials  node[:dirsrv][:credentials]
  value  'on'
end

dirsrv_config "nsslapd-auditlog-logrotationsync-enabled" do
  credentials  node[:dirsrv][:credentials]
  value  'on'
end

dirsrv_entry 'ou=testentry,o=vagrant' do
  credentials  node[:dirsrv][:credentials]
  port        389
  attributes  ({ objectClass: [ 'top', 'organizationalUnit' ], l: [ 'PA', 'CA' ], telephoneNumber: '215-310-5555' })
  prune      ([ :postalCode, :description ])
end

dirsrv_plugin "MemberOf Plugin" do
  credentials  node[:dirsrv][:credentials]
end

dirsrv_plugin "Posix Winsync API" do
  credentials  node[:dirsrv][:credentials]
  attributes ({ posixwinsynccreatememberoftask: 'true' })
end

dirsrv_plugin "referential integrity postoperation" do
  credentials  node[:dirsrv][:credentials]
  attributes ({ :'nsslapd-pluginEnabled' => 'on' })
  action     :modify
end

### Replication ###

# cn=Replication Manager,cn=config

dirsrv_user "Replication Manager" do
  credentials  node[:dirsrv][:credentials]
  basedn 'cn=config'
  relativedn_attribute 'cn'
  password 'CopyCat!'
  is_posix false
end

# o=vagrant replica

dirsrv_replica 'o=vagrant' do
  credentials  node[:dirsrv][:credentials]
  instance     node[:hostname] + '_389'
  role         :consumer
  id           4
end
