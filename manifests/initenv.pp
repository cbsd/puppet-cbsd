# install CBSD
class cbsd::initenv(
  $nodename    = $cbsd::nodename,
  $nat_enable  = $cbsd::nat_enable,
  $nodeip      = $cbsd::nodeip,
  $jnameserver = $cbsd::jnameserver,
  $nodeippool  = $cbsd::nodeippool,
  $fbsdrepo    = $cbsd::fbsdrepo,
  $zfsfeat     = $cbsd::zfsfeat,
  $hammerfeat  = $cbsd::hammerfeat,
  $stable      = $cbsd::stable,
  $parallel    = $cbsd::parallel,
  $sqlreplica  = $cbsd::sqlreplica,
  $workdir     = $cbsd::workdir,
  $natip       = $cbsd::natip,
) {
    exec { 'create_initenv':
      command     => "/usr/local/cbsd/sudoexec/initenv ${cbsd::initenv_tmp}",
      refreshonly => true,
      onlyif      => "/bin/test -f ${cbsd::distdir}/sudoexec/initenv",
    }

    file { $cbsd::initenv_tmp:
      ensure  => present,
      mode    => '0440',
      content => template("${module_name}/initenv.conf.erb"),
      owner   => 'cbsd',
      notify  => Exec['create_initenv'],
    }
}
