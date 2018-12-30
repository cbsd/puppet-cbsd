# manage bhyve emulator
define cbsd::bhyve (
  $workdir               = $cbsd::params::workdir,
  $relative_path         = $cbsd::params::relative_path,
  $host_hostname         = $cbsd::params::host_hostname,
  $ip4_addr              = $cbsd::params::ip4_addr,
  $mount_devfs           = $cbsd::params::mount_devfs,
  $allow_mount           = $cbsd::params::allow_mount,
  $allow_devfs           = $cbsd::params::allow_devfs,
  $allow_nullfs          = $cbsd::params::allow_nullfs,
  $mount_fstab           = $cbsd::params::mount_fstab,
  $arch                  = $cbsd::params::arch,
  $mkhostsfile           = $cbsd::params::mkhostsfile,
  $devfs_ruleset         = $cbsd::params::devfs_ruleset,
  $ver                   = $cbsd::params::ver,
  $basename              = $cbsd::params::basename,
  $baserw                = $cbsd::params::baserw,
  $mount_src             = $cbsd::params::mount_src,
  $mount_obj             = $cbsd::params::mount_obj,
  $mount_kernel          = $cbsd::params::mount_kernel,
  $mount_ports           = $cbsd::params::mount_ports,
  $astart                = $cbsd::params::astart,
  $data                  = $cbsd::params::data,
  $vnet                  = $cbsd::params::vnet,
  $applytpl              = $cbsd::params::applytpl,
  $mdsize                = $cbsd::params::mdsize,
  $rcconf                = $cbsd::params::rcconf,
  $floatresolv           = $cbsd::params::floatresolv,
  $zfs_snapsrc           = $cbsd::params::zfs_snapsrc,

  $exec_poststart        = $cbsd::params::exec_poststart,
  $exec_poststop         = $cbsd::params::exec_poststop,
  $exec_prestart         = $cbsd::params::prestart,
  $exec_prestop          = $cbsd::params::prestop,

  $exec_master_poststart = $cbsd::params::exec_master_poststart,
  $exec_master_poststop  = $cbsd::params::exec_master_poststop,
  $exec_master_prestart  = $cbsd::params::exec_master_prestart,
  $exec_master_prestop   = $cbsd::params::exec_mster_prestop,
  $pkg_bootstrap         = $cbsd::params::pkg_bootstrap,
  $interface             = $cbsd::params::interface,
  $jailskeldir           = $cbsd::params::jailskeldir,
  $jail_profile          = $cbsd::params::jail_profile,
  $exec_start            = $cbsd::params::exec_start,
  $exec_stop             = $cbsd::params::exec_stop,
  $emulator              = 'bhyve',

  $disable               = undef,
  $ensure                = 'present',
  $service_autorestart   = true,
  $template              = '',
  $status                = 'running',
  $depend                = '',
  # bhyve
  $imgsize               = $cbsd::params::imgsize,
  $vm_os_profile         = $cbsd::params::vm_os_profile,
  $vm_os_type            = $cbsd::params::vm_os_type,
  $vm_ram                = $cbsd::params::vm_ram,
) {
  include ::cbsd

  $bool_disable=str2bool($disable)
  $bool_service_autorestart=str2bool($service_autorestart)

  $config_system_dir = "${workdir}/jails-system"

  file { "${config_system_dir}/${name}":
    ensure => directory,
  }

  $manage_file_path = "${config_system_dir}/${name}/puppet.conf"

  $manage_service_autorestart = $bool_service_autorestart ? {
    true     => "Service[bhyve-${name}]",
    default  => undef,
  }

  $manage_file_content = $template ? {
    ''      => template($cbsd::bhyve_template),
    default => template($bhyve_template),
  }

  $manage_file_ensure = $bool_disable ? {
    true    => 'absent',
    default => 'present',
  }

  $check_bhyve_status_cmd="/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd jstatus ${name}"

  if $ensure == 'absent' {
    exec { "remove_bhyve_${name}":
      command => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd bremove inter=0 jname=${name}",
      unless  => $check_bhyve_status_cmd,
    }
  } else {
    exec {"create_bhyve_${name}":
      command     => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd bcreate inter=0 jconf=${manage_file_path} autorestart=1",
      refreshonly => true,
      onlyif      => "/bin/test -f ${manage_file_path}",
    }
    file { "bhyve.conf-${name}":
      ensure  => $ensure,
      path    => $manage_file_path,
      owner   => $cbsd::config_file_owner,
      group   => $cbsd::config_file_group,
      mode    => $cbsd::config_file_mode,
      content => $manage_file_content,
      notify  => Exec["create_bhyve_${name}"],
      require => File["${config_system_dir}/${name}"],
    }
    service { "bhyve-${name}":
      ensure     => $status,
      hasrestart => false,
      start      => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd bstart inter=0 ${name}",
      stop       => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd bstop inter=0 ${name}",
      restart    => "/usr/bin/env NOCOLOR=1 /usr/local/bin/cbsd brestart inter=0 ${name}",
      status     => "/bin/test -e /dev/vmm/${name}",
      require    => File["bhyve.conf-${name}"],
    }
  }
}
