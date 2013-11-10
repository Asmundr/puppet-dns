class dns::server::params {
  case $osfamily {
    'Debian': {
       $cfg_dir = '/etc/bind'
       $group   = 'bind'
       $owner   = 'bind'
       $package = 'bind9'
       $service = 'bind9'
       $necessary_packages = [ 'bind9', 'dnssec-tools']
    }
    'RedHat': {
      case $operatingsystem {
        'Fedora': {
          $cfg_dir = '/etc/bind'
          $group   = 'named'
          $owner   = 'named'
          $package = 'bind'
          $service = 'named'
          $necessary_packages = [ 'bind', 'dnssec-tools']
        }
        default: {
          fail("dns::server isn't supported on all RedHat versions")
        }
      }
    }
    default: { 
      fail("dns::server is incompatible with this osfamily: ${::osfamily}")
    }
  }
}
