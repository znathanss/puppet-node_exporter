class node_exporter {
  include node_exporter::install
  include node_exporter::service
  include node_exporter::config
}
