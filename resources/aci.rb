#
# Cookbook Name:: dirsrv
# Resource:: aci
#
# Copyright 2014 Riot Games, Inc.
# Author:: Alan Willis <alwillis@riotgames.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

actions :set, :unset
default_action :set

attribute :label, :kind_of => String, :name_attribute => true
attribute :distinguished_name, :kind_of => String, :required => true
attribute :mode, :kind_of => [ :set, :append, :prune ], :default => :set
attribute :aci_users, :kind_of => Array, :default => [ 'anyone' ]
attribute :aci_rights_permissions, :kind_of => Array, :default => [ 'all' ]
attribute :aci_rights_permit, :kind_of => [ 'allow', 'deny' ], :default => 'allow'
attribute :aci_attrs, :kind_of => Array, :default => [ '*' ]
attribute :aci_attrs_not, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :aci_hosts, :kind_of => String
attribute :aci_dayofweek, :kind_of => String
attribute :aci_timeofday, :kind_of => String
attribute :host, :kind_of => String, :default => 'localhost'
attribute :port, :kind_of => Integer, :default => 389
attribute :credentials, :kind_of => [ String, Hash ], :default => 'default_credentials'
attribute :databag_name, :kind_of => String
