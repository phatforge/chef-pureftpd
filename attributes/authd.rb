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

default['pureftpd']['service']                    = "pure-ftpd-authd"
default['pureftpd']['authd']['service_dir']       = "/etc/init.d"

default['pureftpd']['authd']['enable'] = false
default['pureftpd']['authd']['daemon'] = nil


default['pureftpd']['authd']['sock_path']         = '/var/run/pure-ftpd/pure-ftpd.sock'
default['pureftpd']['authd']['conf']['ExtAuth']   = pureftpd['authd']['sock_path']

default['pureftpd']['authd']['auth']['60extauth'] = "#{node['pureftpd']['base_config_dir']}/conf/ExtAuth"

case platform
when 'ubuntu','debian'
  default['pureftpd']['packages']                         = %w{pure-ftpd-common}
  default['pureftpd']['authd']['service_dir']             = "/etc/init.d"
end

