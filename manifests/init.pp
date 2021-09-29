# Class: cbsd
# ===========================
#
# This module configures the CBSD
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
# [*install_method*]
#  Installation method: git or package
#
# Examples
# --------
#
# @example
#    class { 'cbsd': }
#
# Authors
# -------
#
# Author Name <olevole@olevole.ru>
#
class cbsd (
  $bhyve_template      = $cbsd::params::bhyve_template,
  $cbsd                = $cbsd::params::cbsd,
  $config_system_dir   = $cbsd::params::config_system_dir,
  $fbsdrepo            = $cbsd::params::fbsdrepo,
  $git_url             = $cbsd::params::git_url,
  $hammerfeat          = $cbsd::params::hammerfeat,
  $install_method      = $cbsd::params::install_method,
  $jnameserver         = $cbsd::params::jnameserver,
  $nat_enable          = $cbsd::params::nat_enable,
  $natip               = $cbsd::params::natip,
  $nodeip              = $cbsd::params::nodeip,
  $nodeip6             = $cbsd::params::nodeip6,
  $nodeippool          = $cbsd::params::nodeippool,
  $nodeip6pool         = $cbsd::params::nodeip6pool,
  $nodename            = $cbsd::params::nodename,
  $parallel            = $cbsd::params::parallel,
  $sqlreplica          = $cbsd::params::sqlreplica,
  $workdir             = $cbsd::params::workdir,
  $zfsfeat             = $cbsd::params::zfsfeat,
  Hash $jail           = {},
  Hash $bhyve          = {},
  String $service_name = $cbsd::params::service_name,
) inherits cbsd::params {

  if $my_class != '' {
    include $my_class
  }

  contain cbsd::install
  contain cbsd::initenv
  contain cbsd::prepare
  contain cbsd::service

  Class['cbsd::prepare']
  -> Class['cbsd::install']
  -> Class['cbsd::initenv']
  -> Class['cbsd::service']

  # create defined cbsd
  create_resources('cbsd::jail', $jail)
  create_resources('cbsd::bhyve', $bhyve)
}
