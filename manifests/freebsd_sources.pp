# manage FreeBSD sources for CBSD
class cbsd::freebsd_sources (
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
    $sources="src_${rver}"
    $sources_path="${cbsd::workdir}/src/${sources}"
    exec { "cbsd_add_sources_${rver}":
      command => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd srcup ver=${rver}",
      unless  => "/bin/test -r ${sources_path}/src/Makefile",
      onlyif  => '/usr/local/bin/cbsd version',
    }
  }
}
