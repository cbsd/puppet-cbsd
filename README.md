# CBSD puppet

Manage FreeBSD CBSD with puppet.

## Simple implementation

All parameters from [jail(8)](http://www.freebsd.org/cgi/man.cgi?query=jail&sektion=8) are applicable to either the class defaults or to any jail.

```Puppet

class { 'cbsd':
	defaults => {
		'workdir'         => '/usr/jails',
	}
}

cbsd::jail { 'myjail0':
	pkg_bootstrap => '0',
	host_hostname => 'myjail0.my.domain',
}

```

Jails can be easily managed from Hiera as well:
```YAML
cbsd::jails:
    myjail0:
	host_hostname: 'myjail0.my.domain'
```
