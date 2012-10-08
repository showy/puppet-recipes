
class prelude::sensor::ossec {

  include prelude

  package { "libprelude-dev":
    ensure  => present,
  }
}
