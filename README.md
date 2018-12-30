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
	jnameserver => "8.8.8.8",
	nat_enable => '1',
}

# If you install cbsd manually: don't use pkg for
# installing CBSD:

class { 'cbsd':
	manage_repo => false,
	workdir => '/usr/jails',
}

# fetch specified base from the repo
class { "cbsd::freebsd_bases":
	ver => [ '12' ],
	stable => 1,
}

cbsd::jail { 'myjail0':
	pkg_bootstrap => '0',
	host_hostname => 'myjail0.my.domain',
}
cbsd::jail { 'myjail1':
	pkg_bootstrap => '0',
	host_hostname => 'myjail1.my.domain',
	ensure => 'absent',
	status => 'stopped'
}

```

Jails can be easily managed from Hiera as well:
```YAML
cbsd::jails:
  myjail0:
    host_hostname: 'myjail0.my.domain'
```

## Limitations

Works with FreeBSD 10+ and CBSD 11.0.0+

Currently only jail is supported by this module. Bhyve and XEN - work in progress.

## Contributing

* Fork it
* Commit your changes (`git commit -am 'Added some feature'`)
* Push to the branch (`git push`)
* Create new Pull Request
