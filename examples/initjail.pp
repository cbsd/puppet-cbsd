# CBSD jail examples
class { 'cbsd':
  jnameserver => '8.8.8.8',
  nat_enable  => 'pf',
  workdir     => '/usr/jails',
}

class { 'cbsd::freebsd_bases':
  ver    => [ 'native' ],
  stable => 0,
}

cbsd::jail { 'myjail0':
  pkg_bootstrap => '0',
  host_hostname => 'myjail0.my.domain',
  #ensure       => absent,
  status        => 'stopped',
  ver           => 'native',
}

cbsd::jail { 'cbsdpuppet1':
  pkg_bootstrap => '1',
  jprofile      => 'cbsdpuppet',
  astart        => '0',
  status        => 'stopped',
  ver           => 'native',
}
