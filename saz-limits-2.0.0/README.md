# puppet-limits

[![Build Status](https://secure.travis-ci.org/saz/puppet-limits.png)](http://travis-ci.org/saz/puppet-limits)

Manage user and group limits via Puppet

## How to use

### Purge limits.d directory

```ruby
    limits::limits { 'username_nofile':
      ensure     => present,
      user       => 'username',
      limit_type => 'nofile',
      hard       => 16384,
      soft       => 16384,
    }
```
### Do NOT purge limits.d directory

```ruby
    class { 'limits':
      purge_limits_d_dir => false,
    }

    limits::limits { 'username_nofile':
      ensure     => present,
      user       => 'username',
      limit_type => 'nofile',
      hard       => 16384,
    }
```

One or both of hard and soft must be set!
