class jenkins {
  package {
    "jenkins":
      ensure => installed,
  }

  file {
    "/var/lib/jenkins/plugins/maven-plugin-1.509.2.hpi":
      ensure => file,
      source => "puppet:///modules/jenkins/maven-plugin-1.509.2.hpi",
      require => Package["jenkins"],
  }
}
