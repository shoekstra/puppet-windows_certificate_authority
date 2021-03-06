# Logic for the module
class windows_certificate_authority::adcscertificationauthority (
    $kernel_ver          = $windows_certificate_authority::kernel_ver,
    $catype              = $windows_certificate_authority::catype,
    $keylength           = $windows_certificate_authority::keylength,
    $validityperiod      = $windows_certificate_authority::validityperiod,
    $validityperiodunits = $windows_certificate_authority::validityperiodunits
) {
  # If the operating system is server 2012 or 2012 R2 then run the appropriate powershell commands otherwise abort with an error message
  if $kernel_ver =~ /^6\.2|^6\.3/ {
    case $catype{
      'enterpriserootca': { include windows_certificate_authority::enterpriserootca }
      'enterprisesubordinateca': { include windows_certificate_authority::enterprisesubca }
      'standalonerootca': { include windows_certificate_authority::standalonerootca }
      'standalonesubordinateca': { include windows_certificate_authority::standalonesubca }
    }
  } else {
    fail ('This operating system is not supported')
  }
}
