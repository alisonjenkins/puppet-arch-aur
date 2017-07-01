# arch-aur - Used for managing installation and configuration
# of arch linux arch user repository packages.
#
# @author Alan Jenkins
#
# @example Default - This will by default ensure arch-aur is installed and ready for use.
#   include arch-aur
#
# @example Override default install location
#   class {'arch-aur': }

class arch_aur (
  $cower_aur_download_url        = $::arch_aur::params::cower_download_url,
) inherits ::arch_aur::params {


validate_string($choco_install_location)
# lint:ignore:140chars
validate_re($choco_install_location, '^\w\:',
"Please use a full path for choco_install_location starting with a local drive. Reference choco_install_location => '${choco_install_location}'."
)
# lint:endignore

  validate_bool($use_7zip)
  validate_integer($choco_install_timeout_seconds)

  validate_string($chocolatey_download_url)
# lint:ignore:140chars
  validate_re($chocolatey_download_url,['^http\:\/\/','^https\:\/\/','file\:\/\/\/'],
    "For chocolatey_download_url, if not using the default '${::chocolatey::params::download_url}', please use a Http/Https/File Url that downloads 'chocolatey.nupkg'."
  )
# lint:endignore

  validate_bool($enable_autouninstaller)

  if ((versioncmp($::clientversion, '3.4.0') >= 0) and (!defined('$::serverversion') or versioncmp($::serverversion, '3.4.0') >= 0)) {
    class { '::chocolatey::install': }
    -> class { '::chocolatey::config': }

    contain '::chocolatey::install'
    contain '::chocolatey::config'
  } else {
    anchor {'before_chocolatey':}
    -> class { '::chocolatey::install': }
    -> class { '::chocolatey::config': }
    -> anchor {'after_chocolatey':}
  }
}
