class cbsd::install (
 $jnameserver       = $cbsd::params::jnameserver,
 ) inherits cbsd::params {

	package { $cbsd_packages:
		ensure => $ensure,
	}

	exec {"create_initenv":
		command => "/usr/local/cbsd/sudoexec/initenv ${initenv_tmp}",
		refreshonly => true,
	}

	file { "${initenv_tmp}":
		mode => '0444',
		ensure  => present,
		content => template("${module_name}/initenv.conf.erb"),
		owner => "cbsd",
		notify  => Exec["create_initenv"],
		require => Package["${cbsd_packages}"],
	}
}
