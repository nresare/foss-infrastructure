class jenkins {
  package {
    ["jenkins", "openjdk-7-jdk", "maven", "curl"]:
      ensure => installed,
  }

  # the plugin downloader doesn't handle upgrades currently, so you 
  # need to manually remove the old plugin before the new is downloaded
  # when upgrading
  $plugins = {
    'git'                    => { plugin_version => '2.0.1' },
    'git-client'             => { plugin_version => '1.6.1' },
    'ssh-credentials'        => { plugin_version => '1.6' },
    'scm-api'                => { plugin_version => '0.2' },
    'credentials'            => { plugin_version => '1.9.4' },
    'javadoc'                => { plugin_version => '1.1' },
    'mailer'                 => { plugin_version => '1.8' },
    'maven-plugin'           => { plugin_version => '1.509.2' },
    'scm-sync-configuration' => { plugin_version => '0.0.7.3' },
    'subversion'             => { plugin_version => '1.54' },
  }

  service { 'jenkins': ensure => running }

  class { 'jenkins::plugins': plugins => $plugins }

  file { '/var/lib/jenkins/.gitconfig':
    ensure => file,
    source => 'puppet:///modules/jenkins/jenkins-gitconfig',
    owner  => 'jenkins',
    require => Package['jenkins'],
  }

  file { '/var/lib/jenkins/scm-sync-configuration.xml':
    ensure => file,
    source => 'puppet:///modules/jenkins/scm-sync-configuration.xml',
    owner  => 'jenkins',
    require => Package['jenkins'],
  }

  $conf = "https://github.com/noaresare/foss-jenkins-config"

  exec { 'jenkins::clone::config':
    command => "git clone --bare $conf && chown -R jenkins foss-jenkins-config.git",
    cwd => "/var/lib",
    creates => "/var/lib/foss-jenkins-config.git",
    path => "/usr/bin:/bin",
    require => Package['jenkins'],
  }


}
