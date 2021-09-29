# default global params for CBSD
class cbsd::params {
  # jail settings
  $ip4_addr                      = 'DHCP'
  $mount_devfs                   = '1'
  $allow_mount                   = '1'
  $allow_devfs                   = '1'
  $allow_nullfs                  = '1'
  $arch                          = 'native'
  $mkhostsfile                   = '1'
  $devfs_ruleset                 = '4'
  $ver                           = 'native'
  $basename                      = '0'
  $baserw                        = '0'
  $mount_src                     = '0'
  $mount_obj                     = '0'
  $mount_kernel                  = '0'
  $mount_ports                   = '1'
  $astart                        = '1'
  $vnet                          = '0'
  $applytpl                      = '1'
  $mdsize                        = '0'
  $floatresolv                   = '1'
  $zfs_snapsrc                   = '0'

  $exec_poststart                = '0'
  $exec_poststop                 = '0'
  $exec_prestart                 = '0'
  $exec_prestop                  = '0'

  $exec_master_poststart         = '0'
  $exec_master_poststop          = '0'
  $exec_master_prestart          = '0'
  $exec_master_prestop           = '0'
  $pkg_bootstrap                 = '1'
  $interface                     = 'auto'
  $host_hostname                 = $::domain
  $exec_start                    = '/bin/sh /etc/rc'
  $exec_stop                     = '/bin/sh /etc/rc.shutdown'
  $jprofile                      = 'default'
  $relative_path                 = '1'
  $allow_fusefs                  = '0'
  $allow_linprocfs               = '0'
  $allow_linsysfs                = '0'
  $allow_mlock                   = '0'
  $allow_raw_sockets             = '1'
  $allow_reserved_ports          = '0'
  $allow_unprivileged_proc_debug = '0'
  $childrenmax                   = '0'
  $ci_gw4                        = undef
  $etcupdate_init                = '1'
  $fsquota                       = '0'
  $nic_hwaddr                    = undef
  $rctl_nice                     = '1'
  $sysrc_enable                  = undef
  $user_pw_root                  = 'cbsd'
  $mount_fstab                   = undef
  $data                          = undef
  $rcconf                        = undef
  $prestart                      = undef
  $prestop                       = undef
  $exec_mster_prestop            = undef
  $jailskeldir                   = undef

  # general
  $install_method                = 'package'
  $git_url                       = 'https://github.com/cbsd/cbsd.git'
  $ensure                        = 'installed'
  $git_ensure                    = 'installed'
  $ca_root_nss_ensure            = 'installed'
  $tmux_ensure                   = 'installed'
  $pkgconf_ensure                = 'installed'
  $sqlite3_ensure                = 'installed'
  $distdir                       = '/usr/local/cbsd'
  $workdir                       = '/usr/jails'
  $config_file_owner             = 'root'
  $config_file_group             = 'wheel'
  $config_file_mode              = '0444'

  $cbsd                          = {}
  $jail                          = {}
  $my_class                      = ''
  $jail_template                 = 'cbsd/jail.conf.erb'
  $bhyve_template                = 'cbsd/bhyve.conf.erb'
  $service_name                  = 'cbsdd'
  # node
  $nodename                      = $::fqdn
  $nat_enable                    = 'pf'
  $nodeip                        = $::ipaddress
  #$nodeip6                       = 'auto'
  $nodeip6                       = "${facts['networking']['ip6']}"

  $jnameserver                   = '8.8.8.8,8.8.4.4'
  $nodeippool                    = '10.0.0.0/24'
  $nodeip6pool                   = '0'
  $fbsdrepo                      = '1'
  $zfsfeat                       = '1'
  $hammerfeat                    = '0'
  $parallel                      = '5'
  $sqlreplica                    = '1'
  $natip                         = $::ipaddress

  # other/special
  $initenv_tmp                   = '/tmp/initenv.conf'
  $cbsd_packages                 = 'sysutils/cbsd'
  $dist_dir                      = '/usr/local/cbsd'
  $config_system_dir             = ''

  #bhyve
  $imgsize                       = '10g'
  $vm_os_profile                 = 'freebsd'
  $vm_profile                    = 'FreeBSD-x64-13.0'
  $vm_ram                        = '1g'
}
