# default global params for CBSD
class cbsd::params {
  # jail settings
  $install_method     = 'package'
  $git_url            = 'https://github.com/cbsd/cbsd.git'
  $ensure             = 'installed'
  $git_ensure         = 'installed'
  $ca_root_nss_ensure = 'installed'
  $tmux_ensure        = 'installed'
  $distdir            = '/usr/local/cbsd'
  $workdir            = '/usr/jails'
  $config_file_owner  = 'root'
  $config_file_group  = 'wheel'
  $config_file_mode   = '0444'
  $ip4_addr           = 'DHCP'
  $mount_devfs        = '1'
  $allow_mount        = '1'
  $allow_devfs        = '1'
  $allow_nullfs       = '1'
  $arch               = 'native'
  $mkhostsfile        = '1'
  $devfs_ruleset      = '4'
  $ver                = 'native'
  $basename           = '0'
  $baserw             = '0'
  $mount_src          = '0'
  $mount_obj          = '0'
  $mount_kernel       = '0'
  $mount_ports        = '1'
  $astart             = '1'
  $vnet               = '0'
  $applytpl           = '1'
  $mdsize             = '0'
  $floatresolv        = '1'
  $zfs_snapsrc        = '0'

  $exec_poststart     = '0'
  $exec_poststop      = '0'
  $exec_prestart      = '0'
  $exec_prestop       = '0'

  $exec_master_poststart = '0'
  $exec_master_poststop  = '0'
  $exec_master_prestart  = '0'
  $exec_master_prestop   = '0'
  $pkg_bootstrap         = '1'
  $interface             = 'auto'
  $host_hostname         = $::domain
  $jail_profile          = 'default'
  $exec_start            = '/bin/sh /etc/rc'
  $exec_stop             = '/bin/sh /etc/rc.shutdown'
  $emulator              = 'jail'
  $relative_path         = '1'
  $mount_fstab           = undef
  $data                  = undef
  $rcconf                = undef
  $prestart              = undef
  $prestop               = undef
  $exec_mster_prestop    = undef
  $jailskeldir           = undef

  # general
  $cbsd    = {}
  $my_class = ''
  $jail_template  = 'cbsd/jail.conf.erb'
  $bhyve_template = 'cbsd/bhyve.conf.erb'

  # node
  $nodename    = $::fqdn
  $nat_enable  = 'pf'
  $nodeip      = 'default'
  $jnameserver = '8.8.8.8,8.8.4.4'
  $nodeippool  = '10.0.0.0/24'
  $fbsdrepo    = '1'
  $zfsfeat     = '1'
  $hammerfeat  = '0'
  $stable      = '0'
  $parallel    = '5'
  $sqlreplica  = '1'
  $natip       = 'default'

  # other/special
  $initenv_tmp   = '/tmp/initenv.conf'
  $cbsd_packages = 'sysutils/cbsd'
  $dist_dir      = '/usr/local/cbsd'
  $config_system_dir = ''

  #bhyve
  $imgsize               = '10g'
  $vm_os_profile         = 'freebsd'
  $vm_profile            = 'FreeBSD-x64-12.0'
  $vm_ram                = '1g'
}
