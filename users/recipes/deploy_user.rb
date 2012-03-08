#
# Cookbook Name:: users
# Recipe:: deploy_users
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

user "deploy" do
  comment "Deploy User"
  home "/home/deploy"
  shell "/bin/sh"
  password "$1$oFxS8Iv0$we9eyyR6WtPKOXUmbTBCe/"
end

directory "/home/deploy/.ssh" do
  owner "deploy"
  group "deploy"
  mode "500"
  action :create
end

file "/home/deploy/.ssh/authorized_keys" do
  content "#{node['user']['ssh-key']}"
  mode 0400
  owner "deploy"
  group "deploy"
end