#
# cookbook Name:: pureftpd
# Attributes:: default
#
# Author:: Pritesh Mehta <pritesh@phatforge.com>
#
# Copyright 2008-2009, Pritesh Mehta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['pureftpd']['service']                    = "pure-ftpd"
default['pureftpd']['base_config_dir']            = "/etc/pure-ftpd"
default['pureftpd']['log_dir']                    = "/var/log/pure-ftpd"

default['pureftpd']['default']['run_mode']        = "standalone" # or 'inetd'
default['pureftpd']['default']['virtual_chroot']  = false
default['pureftpd']['default']['upload_script']   = nil
default['pureftpd']['default']['upload_uid']      = nil
default['pureftpd']['default']['upload_gid']      = nil

# default configurations for base package
default['pureftpd']['base']['conf']['UnixAuthentication'] = "no"
default['pureftpd']['base']['conf']['FSCharset']          = "UTF-8"
default['pureftpd']['base']['conf']['AltLog']             = "clf:/var/log/pure-ftpd/transfer.log"
default['pureftpd']['base']['conf']['MinUID']             = "1000"
default['pureftpd']['base']['conf']['PAMAuthentication']  = "yes"
default['pureftpd']['base']['conf']['PureDB']             = "/etc/pure-ftpd/pureftpd.pdb"
default['pureftpd']['base']['conf']['NoAnonymous']        = "yes"

default['pureftpd']['base']['auth']['65unix']             = "UnixAuthentication"
default['pureftpd']['base']['auth']['70pam']              = "PAMAuthentication"

case platform
when 'ubuntu','debian'
  default['pureftpd']['packages']                         = %w{pure-ftpd-common}
  default['pureftpd']['base_config_dir']                  = "/etc/pure-ftpd"
  default['pureftpd']['log_dir']                          = "/var/log/pure-ftpd"
end

