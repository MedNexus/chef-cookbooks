Basic chef recipes to geared for CentOS deployments (with a splash of OS X for development). These recipes have been tested against centos 6 and amazon's linux ami.

To get started copy over bootstrap-centos.sh to your vanilla Centos 6 installation. Create a solo.json file detailing what you would like installed, and your username / ssh key details. For example:

	{
		"mysql": {
			"password": "somepassword"
		},
	
		"user": {
			"full_name": "John Doe",
			"ssh-key": "YOUR_SSH_KEY_HERE",
			"username": "jdoe"
		},
	
		"run_list": [ "recipe[main::default]" ]
	
	}
	
Edit run_list to include your desired modules, main::default gives reasonable defaults for an apache+passenger+mysql rails platform.