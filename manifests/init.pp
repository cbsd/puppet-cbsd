# Class: cbsd
# ===========================
#
# Full description of class cbsd here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'cbsd':
#      ip4_addr => "10.0.0.5/24",
#    }
#
# Authors
# -------
#
# Author Name <olevole@olevole.ru>
#
# Copyright
# ---------
#
# Copyright 2016 Oleg Ginzburg
#
class cbsd (
    $manage_repo       = $cbsd::params::manage_repo,
    $my_class          = $cbsd::params::my_class,
    $workdir           = $cbsd::params::workdir,
    $config_system_dir = $cbsd::params::config_system_dir,
    $cbsd              = $cbsd::params::cbsd,
    $defaults          = $cbsd::params::defaults,
    $template          = $cbsd::params::template,
    $nodename          = $cbsd::params::nodename,
    $nat_enable        = $cbsd::params::nat_enable,
    $nodeip            = $cbsd::params::nodeip,
    $jnameserver       = $cbsd::params::jnameserver,
    $nodeippool        = $cbsd::params::nodeippool,
    $fbsdrepo          = $cbsd::params::fbsdrepo,
    $zfsfeat           = $cbsd::params::zfsfeat,
    $hammerfeat        = $cbsd::params::hammerfeat,
    $stable            = $cbsd::params::stable,
    $parallel          = $cbsd::params::parallel,
    $sqlreplica        = $cbsd::params::sqlreplica,
    $natip             = $cbsd::params::natip,
) inherits cbsd::params {

    if $my_class != '' {
      include $my_class
    }

    contain '::cbsd::install'
    contain '::cbsd::prepare'

    Class['cbsd::prepare']
    -> Class['cbsd::install']

    #notify { $::cbsd_version: }

    # create defined cbsd
    create_resources('cbsd::jail', $cbsd, $defaults)
}
