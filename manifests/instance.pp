# == Class: dashing::instance
#
# Configuration for a specific dashing instance.
#
# === Parameters
#  [*targz*]             - url of the targz containing the dashing instance
#  [*hostname*]          - Hostname used in apache vhost
#  [*port*]              - listen port used in apache vhost
#  [*dashing_dir*]       - local directory to store the dashing instance (default $dashing::dashing_basepath/$name)
#  [*strip_parent_dir*]  - should the parent directory of the targz be stripped (default true)
#  [*github_oauth*]      - used if your pulling from a private repo, syntax username:token, see https://help.github.com/articles/creating-an-access-token-for-command-line-use/
#
# === Examples
#
#  dashing::instance {'ceph':
#    targz => 'https://github.com/rochaporto/dashing-ceph/tarball/master',
#  }
#
define dashing::instance (
  $targz,
  $hostname,
  $port,
  $dashing_dir = "$dashing::dashing_basepath/$name",
  $strip_parent_dir = true,
  $github_oauth = undef, 
) {

  file {$dashing_dir:
    ensure => directory,
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0644,
  }

  if $strip_parent_dir {
    $strip_parent_cmd = '--strip-components=1'
  }

  if $github_oauth == undef {
  	exec {"dashing-get-$name":
  	  command => "/usr/bin/curl -J -L $targz -o /tmp/$name.tar.gz; /bin/tar -zxvf /tmp/$name.tar.gz -C $dashing_dir $strip_parent_cmd; cd $dashing_dir ; /usr/local/bin/bundle install ; chown -R www-data:www-data $dashing_dir ; /bin/rm /tmp/$name.tar.gz",
  	  unless  => "/bin/ls $dashing_dir/dashboards",
  	}
  } else {
        exec {"dashing-get-$name":
          command => "/usr/bin/curl -J -L -u $github_oauth $targz -o /tmp/$name.tar.gz; /bin/tar -zxvf /tmp/$name.tar.gz -C $dashing_dir $strip_parent_cmd; cd $dashing_dir ; /usr/local/bin/bundle install ; chown -R www-data:www-data $dashing_dir ; /bin/rm /tmp/$name.tar.gz",
          unless  => "/bin/ls $dashing_dir/dashboards",
        }
  }

  apache::vhost { $name:
    servername      => $hostname,
    port            => $port,
    docroot_owner   => $dashing::run_user,
    docroot         => "${dashing_dir}/public",
    before          => Exec["dashing-get-$name"],
  }

  File[$dashing_dir] -> Exec["dashing-get-$name"] 

}

define dashing::instance::local (
  $hostname,
  $port,
  $dashing_dir = "$dashing::dashing_basepath/$name",
) {

  file {$dashing_dir:
    ensure => directory,
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => '0644',
  }

  apache::vhost { $name:
    servername      => $hostname,
    port            => $port,
    docroot_owner   => $dashing::run_user,
    docroot         => "${dashing_dir}/public",
    before          => File[$dashing_dir],
  }

}
