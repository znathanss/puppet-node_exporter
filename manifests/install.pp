# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include node_exporter::install
class node_exporter::install {
  include 'archive'
  $install_path        = '/opt'
  $package_name        = 'node_exporter'
  $package_ensure      = '1.2.2.linux-amd64'
  $repository_url      = 'https://github.com/prometheus/node_exporter/releases/download/v1.2.2'
  $archive_name        = "${package_name}-${package_ensure}.tar.gz"
  $package_source      = "${repository_url}/${archive_name}"
  $username            = 'node_exporter'
  archive { $archive_name:
    path         => "/tmp/${archive_name}",
    source       => $package_source,
    extract      => true,
    extract_path => $install_path,
    creates      => "${install_path}/${package_name}-${package_ensure}",
    cleanup      => true,
  }

  user { $username:
    ensure     => present,
    shell      => '/sbin/nologin',
    home       => "/opt/${package_name}-${package_ensure}",
    managehome => false,
    require    => Archive[$archive_name]
    }

  file { "/opt/${package_name}-${package_ensure}":
    ensure  => directory,
    recurse => true,
    owner   => $username,
    group   => $username,
    require => Archive[$archive_name]
    }
}

