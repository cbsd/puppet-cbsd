# manage FreeBSD bases for CBSD
class cbsd::freebsd_bases (
  $ver    = undef,
  $stable = 0
) inherits cbsd::params {

    if $ver == undef {
      fail("${module_name}: empty ver variable")
    }

    $ver.each |String $ver| {
      $bases="base_amd64_amd64_${ver}"
      $bases_path="${cbsd::workdir}/basejail/${bases}"
      exec { "cbsd_add_bases_${ver}":
        command => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd repo inter=0 action=get sources=base ver=${ver} stable=${stable}",
        unless  => "/bin/test -x ${bases_path}/bin/sh",
        onlyif  => '/usr/local/bin/cbsd version',
      }
    }
}
