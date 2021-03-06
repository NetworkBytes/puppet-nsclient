# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nsclient
#
# Module to install NSClient on Windows.
#
# === Requirements/Dependencies
#
# Currently reequires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*allowed_hosts*]
# Array of hosts that your client can communicate with. You can use netmasks
# (/ syntax) or * to create ranges.
#
# [*service_state*]
# Whether you want to nsclient service to start up. Defaults to running
#
# [*service_enable*]
# Whether you want to nsclient service to start up at boot. Defaults to true
#
# [*package_source_location*]
# This is the default site to download your package from
# (e.g. http://files.nsclient.org/stable)
#
# [*package_source*]
# This is the source name of the package to be downloaded
#
# [*package_name*]
# This is name of the package to download (e.g. NSCP-0.4.1.101-x64.msi)
#
# [*package_install*]
# Boolean (Default: True) whether to install the NSCP package 
#
# [*download_destination*]
# This is the folder to where we need to download the NSCP Installer.
# Package cannot take a remote file source.
# Because of Windows, we need to set this to be a top level directory
# (e.g. c:\\temp) or we would need to recursively check the file path.
#
# [*config_template*]
# This is the template to use as the config file.
#
# === Examples
#
# To install a different version:
#
#   class { 'nsclient':
#     package_source_location => 'http://myhost.com',
#     package_name            => 'NSClient++ (Win32)'
#     package_source          => '0.3.1.msi'
#   }
#
# In order to configure the nagios hosts to communicate with:
#
#   class { 'nsclient':
#     allowed_hosts => ['10.21.0.0/22','10.21.4.0/22'],
#   }
#
class nsclient (
  $allowed_hosts           = $nsclient::params::allowed_hosts,
  $service_state           = $nsclient::params::service_state,
  $service_enable          = $nsclient::params::service_enable,
  $package_source_location = $nsclient::params::package_source_location,
  $package_source          = $nsclient::params::package_source,
  $package_name            = $nsclient::params::package_name,
  $package_install         = $nsclient::params::package_install,
  $download_destination    = $nsclient::params::download_destination,
  $config_template         = $nsclient::params::config_template,
  $check_disk_enabled      = $nsclient::params::check_disk_enabled,
  $check_eventlog_enabled  = $nsclient::params::check_eventlog_enabled,
  $check_scripts_enabled   = $nsclient::params::check_scripts_enabled,
  $check_helpers_enabled   = $nsclient::params::check_helpers_enabled,
  $check_nscp_enabled      = $nsclient::params::check_nscp_enabled,
  $check_system_enabled    = $nsclient::params::check_system_enabled,
  $check_wmi_enabled       = $nsclient::params::check_wmi_enabled,
  $nrpe_server_enabled     = $nsclient::params::nrpe_server_enabled,
  $nsca_client_enabled     = $nsclient::params::nsca_client_enabled,
  $nsclient_server_enabled = $nsclient::params::nsclient_server_enabled,
  $allow_arguments         = $nsclient::params::allow_arguments,
  $insecure_enabled        = $nsclient::params::insecure_enabled,
  $custom_aliases          = $nsclient::params::custom_aliases,
  $external_scripts        = $nsclient::params::external_scripts,
) inherits nsclient::params {

  validate_string($package_source_location)
  validate_string($package_source)
  validate_string($package_name)
  validate_string($config_template)

  class {'nsclient::install':} ->
  class {'nsclient::service':} ->
  Class['nsclient']

}
