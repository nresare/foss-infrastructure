class apache::redirector( $target_port )
{
  package { "apache2":
    ensure => installed,
  }
  service { "apache2":
    ensure => running,
    require => Package['apache2'],
  }

  apache::plugin { ['ssl', 'socache_shmcb', 'proxy_http', 'proxy']: }

  file { "/etc/apache2/sites-enabled/port_forward_proxy.conf":
    content => template("apache/port_forward_proxy.conf.erb"),
    notify => Service["apache2"],
  }

  file { "/etc/apache2/spotify.net_2013.crt":
    source => "puppet:///modules/apache/spotify.net_2013.crt",
    notify => Service["apache2"],
  }

  file { "/etc/apache2/spotify.net_2013.ca-bundle":
    source => "puppet:///modules/apache/spotify.net_2013.ca-bundle",
    notify => Service["apache2"],
  }

  file { "/etc/apache2/spotify.net_2013.key":
    ensure => link,
    target => "ask_ops_to_install",
    notify => Service["apache2"],
  }

}

define apache::plugin ($plugin_basename = $title) {

  file { "/etc/apache2/mods-enabled/${plugin_basename}.load":
    ensure => link,
    target => "../mods-available/${plugin_basename}.load",
    notify => Service["apache2"],
  }
}
