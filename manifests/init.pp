# == Class: dashing
#
# Configures the dashing service and instances.
#
# === Parameters
#  [*dashing_package_name*] - the name of the dashing package (as in gem install <name>)
#  [*package_status*]       - install status of dashing package (installed, latest, ...)
#  [*dashing_conf*]         - dashing configuration file (default /etc/dashing.conf)
#  [*dashing_default*]      - init/upstart defaults (default /etc/default/dashing)
#  [*dashing_binary*]       - name of the dashing binary (for service)
#  [*dashing_basepath*]     - location of the dashing instances (default /usr/share/dashing)
#  [*run_user*]             - user to run the service (default 'www-data')
#  [*run_group*]            - group to run the service (default 'www-data')
#  [*default_vhost*]        - Remove default apache vhost if false (default false)
#
# === Examples
#
#  class {'dashing':
#    run_user  => 'apache2',
#    run_group => 'apache2',
#  }
#
# === Authors
#
# Ricardo Rocha <ricardo@catalyst.net.nz>
#
# === Copyright
#
# Copyright 2014 Catalyst IT, Limited
#
class dashing (
  $dashing_package_name 	   = $dashing::params::dashing_package_name,
  $package_status       	   = $dashing::params::package_status,
  $dashing_binary       	   = $dashing::params::dashing_binary,
  $dashing_basepath     	   = $dashing::params::dashing_basepath,
  $run_user             	   = $dashing::params::run_user,
  $run_group            	   = $dashing::params::run_group,
  $ruby_packages        	   = $dashing::params::ruby_packages,
  $default_vhost 		   = $dashing::params::default_vhost,
  $passenger_high_performance	   = $dashing::params::passenger_high_performance,
  $passenger_pool_idle_time        = $dashing::params::passenger_pool_idle_time,
  $passenger_max_requests          = $dashing::params::passenger_max_requests,
  $passenger_max_pool_size         = $dashing::params::passenger_max_pool_size,
  $passenger_spawn_method          = $dashing::params::passenger_spawn_method,
  $passenger_max_instances_per_app = $dashing::params::passenger_max_instances_per_app,
  $passenger_min_instances         = $dashing::params::passenger_min_instances,
) inherits dashing::params {

  class { 'dashing::install': }
  class { 'dashing::passenger': }

}
