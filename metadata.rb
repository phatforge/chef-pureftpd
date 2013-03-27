name             "pureftpd"
maintainer       "Pritesh Mehta"
maintainer_email "pritesh@phatforge.com"
license          "All rights reserved"
description      "Installs/Configures chef-pureftpd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue "0.1.0"

depends          'apt'
recipe           "pureftpd", "Pure FTPd server install"
recipe           "pureftpd::mysql", "Pure FTPd with MySQL authentication"
recipe           "pureftpd::postgresql", "Pure FTPd with PostgreSQL authentication"
recipe           "pureftpd::ldap", "Pure FTPd with LDAP authentication"

%w{ubuntu}.each do |os|
  supports os
end


