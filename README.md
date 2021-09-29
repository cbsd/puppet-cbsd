# CBSD puppet

#### Table of Contents

1. [Module Description - What does the module do?](#module-description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Contributing - List of module contributors](#contributing)

## Module description

The CBSD module allows you to manage CBSD on FreeBSD platform to create virtual environments ( jail, bhyve, XEN ) with Puppet.

CBSD is wrapper around FreeBSD jail bhyve and XEN. For more information please visit website https://bsdstore.ru/

## Usage

```Puppet
class { 'cbsd':
  #install_method => "git",
  jnameserver    => "8.8.8.8,8.8.4.4",
  nat_enable     => 'pf',
  workdir        => '/usr/jails',
  nodeippool     => '172.16.0.0/24',
  natip          => $::ipaddress,
}
```

```Puppet
# If you install cbsd manually: don't use pkg for
# installing CBSD:
class { 'cbsd':
  manage_repo => false,
  workdir     => '/usr/jails',
}
```

```Puppet
# Manage FreeBSD bases for jail
# fetch specified base from the repo
class { "cbsd::freebsd_bases":
  ver    => [ '13.0' ],
}

cbsd::jail { 'myjail0':
  pkg_bootstrap => '0',
  host_hostname => 'myjail0.my.domain',
}
cbsd::jail { 'myjail1':
  pkg_bootstrap => '0',
  host_hostname => 'myjail1.my.domain',
  ensure        => 'absent',
  status        => 'stopped'
}

```

Hiera example:
```YAML
classes:
  - cbsd
  - cbsd::freebsd_bases

cbsd::jnameserver: "8.8.8.8,8.8.4.4"
cbsd::nat_enable: "pf"
cbsd::workdir: "/usr/jails"
cbsd::nodeippool: "172.16.0.0/24"
cbsd::natip: '%{::ipaddress}'

cbsd::freebsd_bases::ver: [ 'native' ]
#cbsd::freebsd_bases::ver:
#  - '13.0'
#  - '12.2'

cbsd::jail:
  'cbsdpuppet1':
    pkg_bootstrap: '1'
    jprofile: 'cbsdpuppet'
    astart: '0'
    status: 'stopped'
    ver: 'native'
    ip4_addr: '0'
  'test2':
    pkg_bootstrap: '1'
    astart: '1'
    ver: 'native'
    host_hostname: 'myjail0.my.domain'


# Create FreeBSD 13.0-ufs cloud VM via bhyve
cbsd::bhyve:
  'myvm1':
    ensure: absent
    vm_os_type: 'freebsd'
    host_hostname: 'myvm1.my.domain'
    vm_os_profile: 'cloud-FreeBSD-ufs-x64-13.0'
    astart: '0'
    status: 'stopped'
    ip4_addr: '10.0.1.109'
    ci_gw4: '10.0.1.14'

```

## Limitations

Works with FreeBSD 13+ and CBSD 13.0.0+

Currently only jail is supported by this module. Bhyve and XEN - work in progress.

## Contributing

* Fork it
* Commit your changes (`git commit -am 'Added some feature'`)
* Push to the branch (`git push`)
* Create new Pull Request
