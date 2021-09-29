# == Class cbsd::service
#
# This class is meant to be called from cbsd
# It ensure the service is running
#
class cbsd::service {
  service { 'cbsd':
    ensure     => running,
    name       => $cbsd::service_name,
    provider   => 'freebsd',
    enable     => true,
    hasrestart => false,
    hasstatus  => true,
  }
}
