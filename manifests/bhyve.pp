# manage bhyve
define cbsd::bhyve (
  $workdir               = $cbsd::workdir,
  $relative_path         = $cbsd::relative_path,
  $host_hostname         = $cbsd::host_hostname,
  $ip4_addr              = $cbsd::ip4_addr,
  $mount_devfs           = $cbsd::mount_devfs,
  $allow_mount           = $cbsd::allow_mount,
  $allow_devfs           = $cbsd::allow_devfs,
  $allow_nullfs          = $cbsd::allow_nullfs,
  $mount_fstab           = $cbsd::mount_fstab,
  $arch                  = $cbsd::arch,
  $mkhostsfile           = $cbsd::mkhostsfile,
  $devfs_ruleset         = $cbsd::devfs_ruleset,
  $ver                   = $cbsd::ver,
  $basename              = $cbsd::basename,
  $baserw                = $cbsd::baserw,
  $mount_src             = $cbsd::mount_src,
  $mount_obj             = $cbsd::mount_obj,
  $mount_kernel          = $cbsd::mount_kernel,
  $mount_ports           = $cbsd::mount_ports,
  $astart                = $cbsd::astart,
  $data                  = $cbsd::data,
  $vnet                  = $cbsd::vnet,
  $applytpl              = $cbsd::applytpl,
  $mdsize                = $cbsd::mdsize,
  $rcconf                = $cbsd::rcconf,
  $floatresolv           = $cbsd::floatresolv,
  $zfs_snapsrc           = $cbsd::zfs_snapsrc,

  $exec_poststart        = $cbsd::exec_poststart,
  $exec_poststop         = $cbsd::exec_poststop,
  $exec_prestart         = $cbsd::prestart,
  $exec_prestop          = $cbsd::prestop,

  $exec_master_poststart = $cbsd::exec_master_poststart,
  $exec_master_poststop  = $cbsd::exec_master_poststop,
  $exec_master_prestart  = $cbsd::exec_master_prestart,
  $exec_master_prestop   = $cbsd::exec_mster_prestop,
  $pkg_bootstrap         = $cbsd::pkg_bootstrap,
  $interface             = $cbsd::interface,
  $jailskeldir           = $cbsd::jailskeldir,
  $exec_start            = $cbsd::exec_start,
  $exec_stop             = $cbsd::exec_stop,

  $disable               = undef,
  $ensure                = 'present',
  $service_autorestart   = true,
  $template              = '',
  $status                = 'running',
  $depend                = '',
  # bhyve
  $imgsize               = $cbsd::imgsize,
  $vm_os_profile         = $cbsd::vm_os_profile,
  $vm_os_type            = $cbsd::vm_os_type,
  $vm_ram                = $cbsd::vm_ram,
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
    default => template($cbsd::bhyve_template),
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
