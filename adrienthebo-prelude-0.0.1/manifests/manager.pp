
################################################################################
# Prelude manager files
################################################################################
class prelude::manager {

  include prelude::base

  package { "prelude-manager":
    ensure  => installed,
    require => [ Package["libprelude2"], Package["postgresql"], File["/etc/dbconfig-common/prelude-manager.conf"] ],
  }

  file { "/etc/dbconfig-common/prelude-manager.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///prelude/etc/dbconfig-common/prelude-manager.conf",
  }

  file { "/etc/default/prelude-manager":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///prelude/etc/default/prelude-manager",
  }

  file { "/etc/prelude-manager/prelude-manager.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => '0644',
    source  => "puppet:///prelude/etc/prelude-manager/prelude-manager.conf",
    require => [ Package["prelude-manager"], Package["dbconfig-common"] ],
  }

  # Prelude-manager will die if it can't write to the log file.
  file { "/var/log/prelude.log":
    ensure  => present,
    owner   => "prelude",
    group   => "prelude",
    mode    => "0644",
    require => Package["prelude-manager"],
    before  => Service["prelude-manager"],
  }

  service { "prelude-manager":
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
    require     => Package["prelude-manager"],
    subscribe   => File["/etc/prelude-manager/prelude-manager.conf"],
  }

  
}
