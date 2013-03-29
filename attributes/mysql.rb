#
# cookbook Name:: pureftpd
# Attributes:: mysql
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

# default configurations for base package
default['pureftpd']['mysql']['config']            = "#{pureftpd['base_config_dir']}/db/mysql.conf"
