# Class: cbsd
# ===========================
#
# Full description of class cbsd here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'cbsd':
#      ip4_addr => "10.0.0.5/24",
#    }
#
# Authors
# -------
#
# Author Name <olevole@olevole.ru>
#
# Copyright
# ---------
#
# Copyright 2016 Oleg Ginzburg
#
class cbsd (
	$manage_repo       = $cbsd::params::manage_repo,
	$my_class          = $cbsd::params::my_class,
	$workdir           = $cbsd::params::workdir,
	$config_system_dir = $cbsd::params::config_system_dir,
	$cbsd              = $cbsd::params::cbsd,
	$defaults          = $cbsd::params::defaults,
	$template          = $cbsd::params::template,
	$nodename          = $cbsd::params::nodename,
	$nat_enable        = $cbsd::params::nat_enable,
	$nodeip            = $cbsd::params::nodeip,
	$jnameserver       = $cbsd::params::jnameserver,
	$nodeippool        = $cbsd::params::nodeippool,
	$fbsdrepo          = $cbsd::params::fbsdrepo,
	$zfsfeat           = $cbsd::params::zfsfeat,
	$hammerfeat        = $cbsd::params::hammerfeat,
	$stable            = $cbsd::params::stable,
	$parallel          = $cbsd::params::parallel,
	$sqlreplica        = $cbsd::params::sqlreplica,
	$natip             = $cbsd::params::natip,
) inherits cbsd::params {

	if $my_class != '' {
		include $my_class
	}

	include cbsd::prepare

	# create defined cbsd
	create_resources('cbsd::jail', $cbsd, $defaults)

	if $manage_repo {
		package { $cbsd_packages:
			ensure => installed,
		}
	}

	file { "$workdir/cbsd.conf":  }
	exec {"create_initenv":
		command => "/usr/local/cbsd/sudoexec/initenv inter=0 ${initenv_tmp}",
		refreshonly => true,
		onlyif => "test -f $dist_dir/sudoexec/initenv",
		creates => "$workdir/cbsd.conf",
	}

	# delete template if not initialized in workdir
	exec { "rm_template":
		command => "rm ${initenv_tmp}",
		onlyif => "test ! -f $workdir/cbsd.conf",
	}

	file { "${initenv_tmp}":
		mode => '0444',
		ensure  => present,
		content => template("${module_name}/initenv.conf.erb"),
		owner => "cbsd",
		notify  => Exec["create_initenv"],
		require => File["$workdir/cbsd.conf"],
	}

}
