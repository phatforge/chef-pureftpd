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
default['pureftpd']['default']['run_mode']        = "standalone" # or 'inetd'
default['pureftpd']['default']['virtual_chroot']  = true
default['pureftpd']['default']['upload_script']   = nil
default['pureftpd']['default']['upload_uid']      = nil
default['pureftpd']['default']['upload_gid']      = nil

case platform
when 'ubuntu','debian'
  default['pureftpd']['packages'] = %w{pure-ftpd-common}
end

