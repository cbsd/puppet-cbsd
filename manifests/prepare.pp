# prepare environment to setup CBSD
class cbsd::prepare inherits cbsd::params  {
    group { 'cbsd':
      ensure => 'present',
    }
    -> user { 'cbsd':
      ensure => 'present',
      gid    => 'cbsd',
      shell  => '/bin/sh',
    }
    # delete template if not initialized in workdir
    -> exec { 'rm_template':
      command => "/bin/rm ${cbsd::initenv_tmp}",
      onlyif  => "/bin/test ! -f ${cbsd::workdir}/cbsd.conf -a -f ${cbsd::initenv_tmp}",
    }
}
