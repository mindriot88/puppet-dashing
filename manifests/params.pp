# == Class: dashing::params
#
# This defines default configuration values for dashing.  You don't want to use it directly.
#
# === Parameters: None
#
# === Examples
#
#  class { 'dashing::params': }
#
class dashing::params {

  case $::osfamily {
    debian: {
      $dashing_package_name         = 'dashing'
      $package_status               = 'installed'
      $dashing_binary               = '/usr/local/bin/dashing'
      $dashing_basepath             = '/usr/share/dashing'
      $run_user                     = 'www-data'
      $run_group                    = 'www-data'
      $ruby_packages	      	    = [ 'ruby', 'ruby-dev' ]
      $default_vhost                = false
      $passenger_high_performance   = 'On'
      $passenger_pool_idle_time     = 600
      $passenger_max_requests       = 1000
      $passenger_max_pool_size      = 12
      $passenger_spawn_method          = 'conservative'
      $passenger_max_instances_per_app = 1
      $passenger_min_instances         = 1
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::operatingsystem}")
        }
      }
    }
  }

}
