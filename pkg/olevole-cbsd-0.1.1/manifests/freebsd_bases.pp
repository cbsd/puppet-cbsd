class cbsd::freebsd_bases (
    $ver="",
    $stable=0
) inherits cbsd::params {

	if $ver == "" {
		fail("$module_name: empty ver variable")
	}

	$ver.each |String $ver| {

		$bases="base_amd64_amd64_${ver}"
		$bases_path="${workdir}/basejail/${bases}"

		exec { "cbsd_add_bases_$ver":
			command => "env NOCOLOR=1 /usr/local/bin/cbsd repo inter=0 action=get sources=base ver=${ver} stable=${stable}",
			unless  => "test -x $bases_path/bin/sh",
			require => [ Package[$cbsd_packages], File[$initenv_tmp] ],
		}
	}
}
