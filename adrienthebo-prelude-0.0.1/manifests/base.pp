
################################################################################
# Provides packages for prelude manager and prewikka.
################################################################################
class prelude::base {

  include prelude

  package { "dbconfig-common":
      ensure  => installed,
  }

  package { "postgresql":
    ensure  => installed,
    require => Package["dbconfig-common"]
  }

  package { "postgresql-client":
    ensure  => installed,
  }

  file { "/etc/dbconfig-common":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

}
