define nagios::check::remote (
    $check_command       = $title,                
    $service_description = undef,
    $args                = getvar("$::nagios_${check_command}_args"),
    $servicegroups       = getvar("$::nagios_${check_command}_servicegroups"),
    $check_period        = getvar("$::nagios_${check_command}_check_period"),
    $max_check_attempts  = getvar("$::nagios_${check_command}_max_check_attempts"),
    $notification_period = getvar("$::nagios_${check_command}_notification_period"),
    $use                 = getvar("$::nagios_${check_command}_use"),
    $ensure              = getvar("$::nagios_${check_command}_ensure"),
) {

  $real_service_description = $service_description ? {
    undef   => regsubst($check_command, '^check_(.+)$', '\1'),
    default => regsubst($service_description, '^check_(.+)$', '\1'),
  }

    nagios::service { "${check_command}_${fqdn}":
        check_command       => $args ? {
          undef   => "${check_command}",
          default => "${check_command}!${args}",
        },
        service_description => $real_service_description,
        servicegroups       => $servicegroups,
        check_period        => $check_period,
        max_check_attempts  => $max_check_attempts,
        notification_period => $notification_period,
        use                 => $use,
        ensure              => $ensure,
    }

}

