define nagios::check::procs (
    $args                = $::nagios_check_procs_args,
    $servicegroups       = $::nagios_check_procs_servicegroups,
    $check_period        = $::nagios_check_procs_check_period,
    $max_check_attempts  = $::nagios_check_procs_max_check_attempts,
    $notification_period = $::nagios_check_procs_notification_period,
    $use                 = $::nagios_check_procs_use,
    $ensure              = $::nagios_check_procs_ensure
) {

    nagios::client::nrpe_file { 'check_procs':
        args   => $args ? { '' => '', default => $args },
        ensure => $ensure,
    }

    nagios::service { "check_procs_${title}":
        check_command       => 'check_nrpe_procs',
        service_description => 'procs',
        servicegroups       => $servicegroups,
        check_period        => $check_period,
        max_check_attempts  => $max_check_attempts,
        notification_period => $notification_period,
        use                 => $use,
        ensure              => $ensure,
    }

}

