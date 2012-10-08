
class prelude::prewikka {

  include apache
  include prelude::base

  file { "/etc/dbconfig-common/prewikka.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///prelude/etc/dbconfig-common/prewikka.conf",
  }

  file { "/etc/prewikka/prewikka.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///prelude/etc/prewikka/prewikka.conf",
    require => Package["prewikka"],
  }

  package { "prewikka":
    ensure  => installed,
    require => [ Package["libprelude2"], Package["postgresql"], File["/etc/dbconfig-common/prewikka.conf"] ],
  }

  package { "libapache2-mod-python":
    ensure  => installed,
  }

  apache::a2mod { "python":
    ensure  => present,
    require => Package["libapache2-mod-python"],
    notify  => Service["httpd"], #provided in apache module
  }

  apache::vhost { "prewikka":
    vhost     => 'horus.cat.pdx.edu',
    ssl       => true,
    priority  => '50',
    port      => '443',
    template  => "prelude/prewikka.conf.erb",
  }

  file { "/etc/apache2/certs":
    ensure  => directory,
    recurse => true,
    owner   => 'www-data',
    group   => 'www-data',
    source  => "puppet:///prelude/etc/apache2/certs",
  }
}
