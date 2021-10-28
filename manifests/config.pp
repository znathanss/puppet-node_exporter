class node_exporter::config {
  $options = hiera('node_exporter::options', '--web.listen-address=:9100')
  file { '/etc/default/node_exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('node_exporter/node_exporter.erb'),
    notify  => Service['node_exporter']
  }
}
