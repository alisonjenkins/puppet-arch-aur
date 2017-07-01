# chocolatey::install - Private class used for install of Chocolatey
class arch_aur::install {
  assert_private()

  $cower_download_url = $::arch_aur::cower_download_url

  # exec { 'install_cower':
  #   # command     => template('chocolatey/InstallChocolatey.ps1.erb'),
  #   # creates     => "${::chocolatey::choco_install_location}\\bin\\choco.exe",
  #   # provider    => powershell,
  #   # timeout     => $::chocolatey::choco_install_timeout_seconds,
  #   # logoutput   => $::chocolatey::log_output,
  #   # environment => ["ChocolateyInstall=${::chocolatey::choco_install_location}"],
  #   # require     => Registry_value['ChocolateyInstall environment value'],
  # }
}
