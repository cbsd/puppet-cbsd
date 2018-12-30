# install CBSD
class cbsd::initenv {

    exec { 'create_initenv':
      command     => "/usr/local/cbsd/sudoexec/initenv ${cbsd::params::initenv_tmp}",
      refreshonly => true,
      onlyif      => "/bin/test -f ${cbsd::params::distdir}/sudoexec/initenv",
    }

    file { $cbsd::params::initenv_tmp:
      ensure  => present,
      mode    => '0440',
      content => template("${module_name}/initenv.conf.erb"),
      owner   => 'cbsd',
      notify  => Exec['create_initenv'],
    }
}
