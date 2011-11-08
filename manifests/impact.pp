# Class planet::impact
#
# Sets up a Planet impact node
#
class planet::impact inherits planet {

    service { "impact":
        enable     => true,
        hasstatus  => true,
        require => [ Package["esnplanet"] ],
    }
    file { "/var/log/planet/impact":
        require => [ Package["esnplanet", "esnplanet-framework"] ],
        ensure => directory,
        owner   => "root",
        group   => "root",
    }
    file { "/etc/logrotate.d/planet_impact":
        ensure => present,
        source => "puppet:///modules/planet/impact.logrotate",
        group   => "root",
        owner => "root",
        mode  => "0644",
        require => [ Package["esnplanet", "esnplanet-framework"] ],
    }

}
