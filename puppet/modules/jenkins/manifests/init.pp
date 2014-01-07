class jenkins {
  package {
    ["jenkins", "openjdk-7-jdk", "maven"]:
      ensure => installed,
  }

  file {
    # this file is downloaded from
    # http://updates.jenkins-ci.org/download/plugins/maven-plugin/
    "/var/lib/jenkins/plugins/maven-plugin-1.509.2.hpi":
      ensure => file,
      source => "puppet:///modules/jenkins/maven-plugin-1.509.2.hpi",
      require => Package["jenkins"],
  }
}
