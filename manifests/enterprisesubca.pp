# Configure an Enterprise Subordinate CA
class windows_certificate_authority::enterprisesubca (
    $cacommonname        = $windows_certificate_authority::cacommonname,
    $catype              = $windows_certificate_authority::catype,
    $cryptoprovider      = $windows_certificate_authority::cryptoprovider,
    $hashalgorithm       = $windows_certificate_authority::hashalgorithm,
    $keylength           = $windows_certificate_authority::keylength,
    $parentca            = $windows_certificate_authority::parentca,
    $validityperiod      = $windows_certificate_authority::validityperiod,
    $validityperiodunits = $windows_certificate_authority::validityperiodunits
) {
  if $parentca {
    exec { 'Deploy Enterprise Subordinate ADCS_CA':
      command  => "Install-AdcsCertificationAuthority -OverwriteExistingKey -Force -CAType $catype -CACommonName $cacommonname -CryptoProviderName \'$cryptoprovider\' -KeyLength $keylength -HashAlgorithmName $hashalgorithm -ValidityPeriod $validityperiod -ValidityPeriodUnits $validityperiodunits -ParentCA $parentca",
      provider => powershell,
      unless   => "((Get-CATemplate).Name).Contains('EFS')"
    }
  } else {
    exec { 'Deploy Enterprise Subordinate ADCS_CA':
      command  => "Install-AdcsCertificationAuthority -OverwriteExistingKey -Force -CAType $catype -CACommonName $cacommonname -CryptoProviderName \'$cryptoprovider\' -KeyLength $keylength -HashAlgorithmName $hashalgorithm -ValidityPeriod $validityperiod -ValidityPeriodUnits $validityperiodunits",
      provider => powershell,
      unless   => "((Get-CATemplate).Name).Contains('EFS')"
    }
  }
}
