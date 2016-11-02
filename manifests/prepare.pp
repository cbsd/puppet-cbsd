class cbsd::prepare inherits cbsd::params  {

	group { 'cbsd':
		ensure  => 'present',
	}

	user { 'cbsd':
		ensure  => 'present',
		gid     => 'cbsd',
		shell   => '/bin/sh',
	}

	# Check for correct CBSD installation:
	# execute any command via cbsd and when it failed: re-initialize initenv.conf
	exec { "cbsd_add_bases_$ver":
			command => "/bin/rm -f ${initenv_tmp}",
			unless  => "/usr/local/bin/cbsd date",
			#require => File["$dist_dir/sudoexec/initenv"],
			onlyif => "test ! -f $dist_dir/sudoexec/initenv",
			require => File["$workdir/cbsd.conf"],
	}
}
