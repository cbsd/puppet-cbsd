# manage FreeBSD bases for CBSD
class cbsd::freebsd_bases (
  Optional[Tuple] $ver = undef,
) inherits cbsd::params {

  if $ver == undef {
    fail("${module_name}: empty ver variable, valid: 'native' or Major.Minor, e.g: '12.3', '13.1'")
  }

  $ver.each |String $ver| {

    if $ver == "native" {
      $rver = $facts['kernelversion']
    } else {
      $rver = $ver
    }
    $bases="base_amd64_amd64_${rver}"
    $bases_path="${cbsd::workdir}/basejail/${bases}"
    exec { "cbsd_add_bases_${rver}":
      command => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd repo inter=0 action=get sources=base ver=${rver}",
      unless  => "/bin/test -x ${bases_path}/bin/sh",
      onlyif  => '/usr/local/bin/cbsd version',
    }
  }
}
