#!/bin/bash
chef_binary=/usr/local/rvm/gems/ruby-1.9.2-p318/bin/chef-solo

if ! test -f "$chef_binary"; then
	yum groupinstall -y "Development Tools" 
	yum install -y readline-devel zlib-devel openssl-devel curl-devel libcurl-devel
	bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
	source /etc/profile.d/rvm.sh
	rvm --install 1.9.2-p318
	rvm --default use 1.9.2-p318
	gem install --no-rdoc --no-ri chef
fi 

if ! test -d "chef-cookbooks"; then
	git clone git://github.com/sdang/chef-cookbooks.git
fi

if ! test -f "solo.rb"; then
	echo "root = File.absolute_path(File.dirname(__FILE__))
	file_cache_path root
	cookbook_path root + '/chef-cookbooks'" > solo.rb
fi

"$chef_binary" -c solo.rb -j solo.json