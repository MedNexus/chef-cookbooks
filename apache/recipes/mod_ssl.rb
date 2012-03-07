
package "mod_ssl" do
	package_name "mod_ssl"
	action :install
end

cookbook_file "/etc/httpd/conf.d/mod_ssl.conf" do
  source "mod_ssl.conf"
  mode 0755
  owner "root"
  group "root"
end