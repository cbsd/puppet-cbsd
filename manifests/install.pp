# install CBSD
class cbsd::install {

    case $cbsd::install_method {
      'package': {
         ensure_resource('package', $cbsd::params::cbsd_packages, {'ensure' => $cbsd::params::ensure})
      }
       'git': {
         ensure_resource('package', 'devel/git', {'ensure' => $cbsd::params::git_ensure})
         ensure_resource('package', 'security/ca_root_nss', {'ensure' => $cbsd::params::ca_root_nss_ensure})
         exec { "clone_cbsd":
           command => "/usr/local/bin/git clone ${cbsd::params::git_url} ${cbsd::params::distdir}",
           onlyif => "/bin/test ! -f ${cbsd::params::distdir}/.git/config",
           require => Package['devel/git', 'security/ca_root_nss'],
         }
      }
       'none': {}
       default: {
         fail("The provided install method ${cbsd::install_method} is invalid")
       }
     }
}
