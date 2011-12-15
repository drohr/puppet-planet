# Class planet::orbit
#
# Sets up a Planet orbit node
#

class planet::orbit inherits planet {

    package { [ "esnorbit" ]:
        ensure  => present,
    }

    service { "orbit":
        enable     => true,
        hasstatus  => true,
        require => [ Package["esnplanet"] ],
    }

    file { "/var/log/planet/orbit":
        require => [ Package["esnplanet", "esnplanet-framework"] ],
        ensure => directory,
        owner   => "root",
        group   => "root",
    }

    file { "/etc/logrotate.d/planet_orbit":
        ensure => present,
        source => "puppet:///modules/planet/orbit.logrotate",
        group   => "root",
        owner => "root",
        mode  => "0644",
        require => [ Package["esnplanet", "esnplanet-framework"] ],
    }

}
