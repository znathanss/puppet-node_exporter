class node_exporter::config {
  file { '/etc/default/node_exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('node_exporter/node_exporter.erb')
  }
}
