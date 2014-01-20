node default {
  include jenkins
  class { "apache::redirector":
    target_port => "8080",
  }

  File {
    mode  => '0644',
    owner => 'root',
    group => 'root',
  }

}
