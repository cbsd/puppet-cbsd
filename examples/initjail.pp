class { 'cbsd':
    jnameserver => "8.8.8.8",
    nat_enable  => 'pf',
    defaults    => {
      'workdir' => '/usr/jails',
    }
}

#class { "cbsd::freebsd_bases":
#    ver    => [ '11.0' ],
#    stable => 0,
#}

cbsd::jail { 'myjail0':
    pkg_bootstrap => '0',
    host_hostname => 'myjail0.my.domain',
    #ensure       => absent,
    status        => 'stopped',
}
