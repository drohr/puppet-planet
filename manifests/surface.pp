# Class planet::surface
#
# Sets up a Planet surface node
#
class planet::surface inherits planet {

    # wsgi package verfication
    package { [ "python2.6-mod_wsgi" ]:
        ensure  => present,
    }
    # mod_wsgi.conf
    file { "/etc/httpd/conf.d/mod_wsgi.conf":  
        ensure => present,
        source => "puppet:///modules/planet/mod_wsgi.conf",
        group   => "root",
        owner => "root",
        mode  => "0664",
        require => [ Package["python2.6-mod_wsgi"] ],
    }
    # surface.conf
    file { "/etc/httpd/conf.d/surface.conf":      
        ensure => present,
        source => "puppet:///modules/planet/surface.conf",
        group   => "root",
        owner => "root",
        mode  => "0664",
        notify  => Exec["reload-surface"],
        require => [ Package["esnplanet-framework"] ],
    }
    # service
    service { "surface":
        enable     => true,
        require => [ Package["esnplanet"] ],
    }
    exec { "reload-surface":
        command     => "/etc/init.d/surface restart",
        onlyif      => "/etc/init.d/planet validate",
        require     => Service["surface"],
        refreshonly => true,
    }

}
