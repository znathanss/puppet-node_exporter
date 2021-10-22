# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include node_exporter::service
class node_exporter::service {
  $version = '1.2.2'
  file { '/etc/systemd/system/node_exporter.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('node_exporter/node_exporter.service.erb'),
    notify  => Service['node_exporter']
  }
  exec { 'reload_systemd':
    command     => '/usr/bin/systemctl daemon-reload',
    refreshonly => true,
    subscribe   => File['/etc/systemd/system/node_exporter.service']
  }
  file { '/etc/sysconfig/node_exporter':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    notify => Service['node_exporter'],
  }
  service { 'node_exporter':
    ensure  => true,
    enable  => true,
    require => [
      File['/etc/systemd/system/node_exporter.service'],
      File['/etc/sysconfig/node_exporter']
    ]
  }
}
