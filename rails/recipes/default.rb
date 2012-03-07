#
# Cookbook Name:: rails
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

execute "install rails and passenger" do
  command "gem install --no-rdoc --no-ri rails passenger"
  action :run
  not_if "test -f /usr/local/rvm/gems/ruby-1.9.2-p318/gems/passenger-3.0.11/ext/apache2/mod_passenger.so"
end

execute "setup passenger mod_rails" do
  command "passenger-install-apache2-module -a"
  action :run unless 
  not_if do 
	  File.exists? "/usr/local/rvm/gems/ruby-1.9.2-p318/gems/passenger-3.0.11/ext/apache2/mod_passenger.so"
  end
end

file "/etc/httpd/conf.d/mod_rails.conf" do
  content "
LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.2-p318/gems/passenger-3.0.11/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/rvm/gems/ruby-1.9.2-p318/gems/passenger-3.0.11
PassengerRuby /usr/local/rvm/wrappers/ruby-1.9.2-p318/ruby"
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "/tmp/node-v0.6.12.tar.gz" do
  source "http://nodejs.org/dist/v0.6.12/node-v0.6.12.tar.gz"
  mode "0644"
  not_if do 
	  "/usr/local/bin/node"
  end
end

execute "install node js" do
  command "cd /tmp && tar xvzf node-v0.6.12.tar.gz && cd node-v0.6.12 && ./configure && make install"
  action :run
  not_if do 
	  "/usr/local/bin/node"
  end
end
  
  
