# Configure a Standalone Subordinate CA
class windows_certificate_authority::standalonesubca (
    $cacommonname        = $windows_certificate_authority::cacommonname,
    $catype              = $windows_certificate_authority::catype,
    $cryptoprovider      = $windows_certificate_authority::cryptoprovider,
    $hashalgorithm       = $windows_certificate_authority::hashalgorithm,
    $keylength           = $windows_certificate_authority::keylength,
    $validityperiod      = $windows_certificate_authority::validityperiod,
    $validityperiodunits = $windows_certificate_authority::validityperiodunits
) {
  exec { 'Deploy Standalone Subordinate CA ADCS_CA':
    command  => "Install-AdcsCertificationAuthority -OverwriteExistingKey -Force -CAType $catype -CACommonName $cacommonname -CryptoProviderName \'$cryptoprovider\' -KeyLength $keylength -HashAlgorithmName $hashalgorithm -ValidityPeriod $validityperiod -ValidityPeriodUnits $validityperiodunits",
    provider => powershell,
    unless   => "((Get-CATemplate).Name).Contains('EFS')"
  }
}
