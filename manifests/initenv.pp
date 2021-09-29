# install CBSD
class cbsd::initenv(
  $fbsdrepo    = $cbsd::fbsdrepo,
  $hammerfeat  = $cbsd::hammerfeat,
  $jnameserver = $cbsd::jnameserver,
  $nat_enable  = $cbsd::nat_enable,
  $natip       = $cbsd::natip,
  $nodeip      = $cbsd::nodeip,
  $nodeippool  = $cbsd::nodeippool,
  $nodename    = $cbsd::nodename,
  $parallel    = $cbsd::parallel,
  $sqlreplica  = $cbsd::sqlreplica,
  $workdir     = $cbsd::workdir,
  $zfsfeat     = $cbsd::zfsfeat,
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
