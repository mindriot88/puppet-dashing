# == Class: dashing::passenger
#
# This class makes sure that the required packages are installed.
#
# === Parameters: None
#
# === Examples
#
#  class { 'dashing::passenger': }
#
class dashing::passenger {

	class { 'apache':
		default_vhost => $dashing::default_vhost,
	}

	class { 'apache::mod::headers': }

	class { 'apache::mod::passenger':
     		passenger_high_performance => $dashing::passenger_high_performance,
      		passenger_pool_idle_time => $dashing::passenger_pool_idle_time,
      		passenger_max_requests => $dashing::passenger_max_requests,  
      		passenger_max_pool_size => $dashing::passenger_max_pool_size,      
      		passenger_spawn_method => $dashing::passenger_spawn_method,     
      		passenger_min_instances => $dashing::passenger_min_instances,
	}

}
