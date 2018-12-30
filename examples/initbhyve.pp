class { 'cbsd':
    jnameserver    => "8.8.8.8",
    nat_enable     => 'pf',
    install_method => 'git',
    git_url        => 'https://github.com/cbsd/cbsd.git',
    defaults       => {
      'workdir'    => '/usr/jails',
    }
}

cbsd::bhyve { 'mybhyve0':
    #ensure       => absent,
    status        => 'running',
    imgsize       => '20g',
    interface     => 'auto',
    vm_os_profile => 'freebsd',
    vm_profile    => 'FreeBSD-x64-12.0',
    vm_ram        => '2g',
}
