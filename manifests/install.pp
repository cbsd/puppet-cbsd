# install CBSD
class cbsd::install {

    case $cbsd::install_method {
      'package': {
         ensure_resource('package', $cbsd::params::cbsd_packages, {'ensure' => $cbsd::params::ensure})
      }
       'git': {
      }
       'none': {}
       default: {
         fail("The provided install method ${cbsd::install_method} is invalid")
       }
     }
}
