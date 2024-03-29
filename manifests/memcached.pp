# Class planet::memcached
#
# Sets up a Planet memcached node
#

class planet::memcached {

    # memcached package verfication
    package { [ "memcached" ]:
        ensure  => present,
    }

    # service
    service { "memcached":
        ensure => running,
        enable     => true,
        hasstatus  => true,
        require => [ Package["memcached"], File["/etc/default/memcached"] ],
    }

    # memcached configuration
    file { "/etc/sysconfig/memcached":  
        ensure => present,
        source => "puppet:///modules/planet/memcached",
        group   => "root",
        owner => "root",
        mode  => "0644",
        require => [ Package["memcached"] ],
        notify => Service["memcached"],
    }

}
