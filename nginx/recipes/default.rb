#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2012, Example Com
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

package "nginx" do
	package_name "nginx"
	action :install
end

directory "/www" do
  owner "root"
  mode "0755"
  action :create
end

# create config files
cookbook_file "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  mode 0755
  owner "root"
  group "root"
end

cookbook_file "/etc/nginx/conf.d/ssl.conf" do
  source "ssl.conf"
  mode 0755
  owner "root"
  group "root"
end

cookbook_file "/etc/nginx/conf.d/virtual.conf" do
  source "virtual.conf"
  mode 0755
  owner "root"
  group "root"
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end