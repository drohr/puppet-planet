# Class planet
#
# Sets up Planet
#
class planet {

    # install esnplanet
    package { [ "esnplanet", "esnplanet-framework" ]:
        ensure  => present,
    }
    package { [ "python2.6-libs" ]:
        ensure  => present,
    }
    # planet.yml
    file { "/etc/planet.yml":
        ensure => present,
        source => "puppet:///modules/planet/planet.yml",
        group   => "root",
        owner => "root",
        mode  => "0664",
        notify  => Exec["reload-planet"],
        require => [ Package["esnplanet", "esnplanet-framework"] ],
    }
    # service
    service { "planet":
        require => [ Package["esnplanet"] ],
    }    
    exec { "reload-planet":
        command     => "/etc/init.d/planet restart",
        onlyif      => "/etc/init.d/planet validate",
        require     => Service["planet"],
        refreshonly => true,
    }

}
