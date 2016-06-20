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

## Limitations

Works with FreeBSD 10+ and CBSD 10.3.3+

Currenltry only jail is supported by this module. Bhyve and XEN - work in progress.

## Contributing

* Fork it
* Commit your changes (`git commit -am 'Added some feature'`)
* Push to the branch (`git push`)
* Create new Pull Request

