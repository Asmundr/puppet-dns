class dns::server::config inherits dns::server::params {

  file { $cfg_dir:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }
  file { "${cfg_dir}/zones":
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }
  file { "${cfg_dir}/bind.keys.d/":
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }

  file { "${cfg_dir}/named.conf":
    ensure  => present,
    owner   => $owner,
    group   => $group,
    mode    => '0644',
    require => [File["${cfg_dir}"], Class['dns::server::install']],
    notify  => Class['dns::server::service'],
  }

  concat { "${cfg_dir}/named.conf.local":
    owner   => $owner,
    group   => $group,
    mode    => '0644',
    require => Class['concat::setup'],
    notify  => Class['dns::server::service']
  }

  concat::fragment{'named.conf.local.header':
    ensure  => present,
    target  => "${cfg_dir}/named.conf.local",
    order   => 1,
    content => "// File managed by Puppet.\n"
  }

  case $operatingsystem {
    'Fedora': {
      file { "/etc/sysconfig/named" :
         ensure  => present,
         content => "-c $cfg_dir/named.conf",
         require => Class['dns::server::install'],
      }
    }
    default:{

    }
  }
}
