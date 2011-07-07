# Class: unbound
#
# This module manages unbound
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class unbound::package {

	# Require EPEL  5 REPO

# 	yumrepo {
#        "epel":
#            descr => "Epel-5",
#	    baseurl => "http://mirror.eurid.eu/epel/5/i386/",
#            enabled => 1,
#            gpgcheck => 0,
#    	}

	
	
	package {
		"unbound":
			ensure => present;
	}


}



# EOC unbound::package 


class unbound::enabled inherits unbound{
 Service["unbound"] {
        ensure => "running" ,
        enable => "true",
    }
}

# EOC unbound::enabled 
class unbound::disabled {
 Service["unbound"] {
        ensure => "stopped" ,
        enable => "false",
    }

}
# EOC unbound::disabled 

class unbound::configure 
(
	$verbosity ="1",
	$interfaces=[], 
	$doip6 = "no",
	$port = "53",
	$controlenable = "yes",
	$accesscontrols=[])
{ 
	
	file  {
		"/etc/unbound/":
			ensure => directory;

		"/etc/unbound/unbound.conf":
			owner => "root",
			group => "unbound",
			content => template("unbound/unbound.conf.erb");
	}

			


}
	

# EOC unbound::configure



class unbound {
	include unbound::package 
	class { "unbound::configure":
			interfaces => ["127.0.0.1"],
			accesscontrols => ["0.0.0.0/0 refuse","127.0.0.0/8 allow_snoop"];

	}  

}
