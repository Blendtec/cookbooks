#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2009-2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node[:deploy].each do |app_name, deploy|

template "#{deploy[:deploy_to]}/current/wp-config.php" do
  source 'wp-config.php.erb'
  variables(
      :db_name => (deploy[:database][:database] rescue nil),
      :db_user => (deploy[:database][:username] rescue nil),
      :db_password => (deploy[:database][:password] rescue nil),
      :db_host => (deploy[:database][:host] rescue nil),
      :auth_key => node['wordpress']['keys']['auth'],
      :secure_auth_key => node['wordpress']['keys']['secure_auth'],
      :logged_in_key => node['wordpress']['keys']['logged_in'],
      :nonce_key => node['wordpress']['keys']['nonce'],
      :auth_salt => node['wordpress']['salt']['auth'],
      :secure_auth_salt => node['wordpress']['salt']['secure_auth'],
      :logged_in_salt => node['wordpress']['salt']['logged_in'],
      :nonce_salt => node['wordpress']['salt']['nonce'],
      :lang => node['wordpress']['languages']['lang']
  )
  action :create
end
end
