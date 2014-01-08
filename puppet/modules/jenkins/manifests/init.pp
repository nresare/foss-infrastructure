class jenkins {
  package {
    ["jenkins", "openjdk-7-jdk", "maven", "curl"]:
      ensure => installed,
  }


  $plugins = {
    'git'             => { plugin_version => '2.0' },
    'ssh-credentials' => { plugin_version => '1.6' },
    'scm-api'         => { plugin_version => '0.2' },
    'credentials'     => { plugin_version => '1.9.4' },
    'javadoc'         => { plugin_version => '1.1' },
    'mailer'          => { plugin_version => '1.8' },
    'maven-plugin'    => { plugin_version => '1.509.2' },
  }


  class { 'jenkins::plugins': plugins => $plugins }
}
