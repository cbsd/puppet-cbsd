# install CBSD
class cbsd::install {

    case $cbsd::install_method {
      'package': {
         ensure_resource('package', $cbsd::cbsd_packages, {'ensure' => $cbsd::ensure})
      }
       'git': {
         ensure_resource('package', $cbsd::cbsd_packages, {'ensure' => 'absent'})
         ensure_resource('package', 'devel/git', {'ensure' => $cbsd::git_ensure})
         ensure_resource('package', 'security/ca_root_nss', {'ensure' => $cbsd::ca_root_nss_ensure})
         ensure_resource('package', 'sysutils/tmux', {'ensure' => $cbsd::tmux_ensure})
         exec { "clone_cbsd":
           command => "/usr/local/bin/git clone ${cbsd::git_url} ${cbsd::distdir}",
           onlyif => "/bin/test ! -f ${cbsd::distdir}/.git/config",
           require => Package['devel/git', 'security/ca_root_nss'],
         }
      }
       'none': {}
       default: {
         fail("The provided install method ${cbsd::install_method} is invalid")
       }
     }
}
