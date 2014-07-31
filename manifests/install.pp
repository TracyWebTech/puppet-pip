
define pip::install(
  $package = $title,
  $version = undef,
  $python_version = '2.7',
  $ensure = present,
) {

  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
  }

  case $ensure {
    present: {
      if $version != undef {
        $package_with_version = "$package==$version"
      } else {
        $package_with_version = $package
      }

      exec { "install-$package":
        command => "pip$python_version install $package_with_version",
        unless  => "pip$python_version freeze | grep '^$package_with_version$'",
      }
    }

    absent: {
      exec { "uninstall-$package":
        command => "pip$python_version uninstall $package -y",
        onlyif  => "pip$python_version freeze | cut -d= -f1 | egrep '^$package$'",
      }
    }
  }
}
