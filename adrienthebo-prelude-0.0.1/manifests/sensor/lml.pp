
class prelude::sensor::lml {

  include prelude

  package { "prelude-lml":
    ensure  => installed
  }

  service { "prelude-lml":
    ensure    => running,
    enable    => true,
    require   => Package["prelude-lml"],
    subscribe => File["/etc/prelude/default/client.conf"],
  }
}
