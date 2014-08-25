define nagios::check::nrpe (
    $check_command       = $title,                
    $plugin              = undef,
    $args                = getvar("$::nagios_${check_command}_args"),
    $servicegroups       = getvar("$::nagios_${check_command}_servicegroups"),
    $check_period        = getvar("$::nagios_${check_command}_check_period"),
    $max_check_attempts  = getvar("$::nagios_${check_command}_max_check_attempts"),
    $notification_period = getvar("$::nagios_${check_command}_notification_period"),
    $use                 = getvar("$::nagios_${check_command}_use"),
    $ensure              = getvar("$::nagios_${check_command}_ensure"),
) {

    nagios::client::nrpe_file { $check_command:
        plugin => $plugin,
        args   => $args,
        ensure => $ensure,
    }

    nagios::check::remote { "check_nrpe!${check_command}":
#        check_command       => "check_nrpe!${check_command}",
        service_description => $check_command,
        servicegroups       => $servicegroups,
        check_period        => $check_period,
        max_check_attempts  => $max_check_attempts,
        notification_period => $notification_period,
        use                 => $use,
        ensure              => $ensure,
    }

}

