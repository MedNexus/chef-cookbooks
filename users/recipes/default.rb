#
# Cookbook Name:: users
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

user "personal user" do
  comment "#{node[user][full_name]}"
  home "/home/#{node[user][username]}"
  shell "/bin/bash"
end

directory "/home/#{node[user][username]}/.ssh" do
  owner "#{node[user][username]}"
  group "#{node[user][username]}"
  mode "500"
  action :create
end

cookbook_file "/home/#{node[user][username]}/.ssh/authorized_keys" do
  content "#{node[user][ssh-key]}"
  mode 0400
  owner "#{node[user][username]}"
  group "#{node[user][username]}"
end