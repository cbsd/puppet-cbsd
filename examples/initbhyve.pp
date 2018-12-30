class { 'cbsd':
    jnameserver    => "8.8.8.8",
    nat_enable     => 'pf',
    install_method => 'git',
    git_url        => 'https://github.com/cbsd/cbsd.git',
}

cbsd::bhyve { 'mybhyve0':
    #ensure       => absent,
    status        => 'running',
    imgsize       => '20g',
    interface     => 'auto',
    vm_os_type    => 'freebsd',
    vm_os_profile => 'FreeBSD-x64-12.0',
    vm_ram        => '2g',
}
