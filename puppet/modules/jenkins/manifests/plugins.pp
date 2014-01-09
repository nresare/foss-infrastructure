class jenkins::plugins(
  $plugins
)
{
  create_resources('jenkins::plugin', $plugins)
  file { "/var/lib/jenkins/plugins":
    ensure => directory,
    mode => 755,
    owner => 'jenkins',
    group => 'nogroup',
    require => Package['jenkins'],
  }   
}

define jenkins::plugin(
  $plugin_version,
  $plugin_name = $title,
  $plugin_dir = '/var/lib/jenkins/plugins',
  $server_url = 'http://updates.jenkins-ci.org/',
)
{
  $plugin_path = "${plugin_dir}/${plugin_name}.hpi"
  $url = "${server_url}/download/plugins/${plugin_name}/${plugin_version}/${plugin_name}.hpi"

  # The -L of curl is needed since Jenkins has multiple levels of HTTP redirects
  # for the download of plugins.
  exec { "jenkins::plugin::install::${plugin_name}":
    command => "/usr/bin/curl ${url} -Lo ${plugin_path}",
    creates => $plugin_path,
    require => Package['curl'],
  } ->
  file { $plugin_path:
    ensure => 'file',
    owner  => 'jenkins',
    group  => 'nogroup',
    notify => Service['jenkins'],
    require => File['/var/lib/jenkins/plugins'],
  }
}
