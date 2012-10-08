
class prelude {

  package { "libprelude2":
    ensure  => installed,
  }

  file { "/etc/prelude/default/client.conf":
    ensure  => present,
    source  => "puppet:///prelude/etc/prelude/default/client.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package["libprelude2"],
  }
}
