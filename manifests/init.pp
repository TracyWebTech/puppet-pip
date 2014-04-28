
class pip {
  ensure_packages(['curl'])

  $get_pip_url = 'https://raw.github.com/pypa/pip/1.5.4/contrib/get-pip.py'

  exec { 'install-pip':
    command => "curl -L $get_pip_url | python",
    path    => ['/usr/bin', '/usr/local/bin', '/bin/'],
    unless  => 'which pip',
    require => Package['curl'],
  }
}
