#
# Copyright:: Copyright (c) 2010-2011, Heavy Water Software
# Copyright:: Copyright (c) 2012, Joshua Timberman
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :create do
  begin
    require "rubygems"
    require "dnsimple"
  rescue LoadError
    Chef::Log.error("Missing gem 'dnsimple'")
  end

  domain =  new_resource.domain
  name =    new_resource.name
  content = new_resource.content
  type =    new_resource.type
  ttl =     new_resource.ttl
  prio =    new_resource.priority

  DNSimple::Client.username = new_resource.username || node["dnsimple"]["username"]
  DNSimple::Client.password = new_resource.password || node["dnsimple"]["password"]

  zone = DNSimple::Domain.find(domain)
  records = DNSimple::Record.all(zone)

  exists = false
  records.each do |r|
    Chef::Log.debug "Checking if #{name} exists as #{content} and #{ttl}"
    # do nothing if the record already exists
    exists = (( r.name == name ) and
              ( r.record_type == type ) and
              ( r.content == content ) and
              ( r.ttl == ttl ))
    break if exists

    # delete any record with the name we're trying to create
    if r.name == name
      Chef::Log.debug "Cannot modify a record, must destroy #{name} first"
      r.destroy
    end
  end

  if !exists
    begin
      Chef::Log.info "Attempting to create record type #{type} for #{name} as #{content}"
      record = DNSimple::Record.create( zone,
                                        name,
                                        type,
                                        content,
                                        :ttl => ttl, :prio => prio )

      new_resource.updated_by_last_action(true)
      Chef::Log.info "DNSimple: created #{type} record for #{name}.#{domain}"
    rescue DNSimple::RecordExists
      Chef::Log.debug "DNSimple: #{name}.#{domain} already exists, moving on"
    rescue DNSimple::Error => err
      Chef::Log.error "DNSimple: #{name}.#{domain} could not be created: #{err}"
    end
  end
end

action :destroy do
  begin
    require "rubygems"
    require "dnsimple"
  rescue LoadError
    Chef::Log.error("Missing gem 'dnsimple'")
  end

  DNSimple::Client.username = new_resource.username || node["dnsimple"]["username"]
  DNSimple::Client.password = new_resource.password || node["dnsimple"]["password"]

  zone = DNSimple::Domain.find(new_resource.domain)
  records = DNSimple::Record.all(zone)

  records.each do |r|
    if ( r.name == new_resource.name ) and ( r.record_type == new_resource.type )
      r.destroy
      new_resource.updated_by_last_action(true)
      Chef::Log.info "DNSimple: destroyed #{new_resource.type} record " +
        "for #{new_resource.name}.#{new_resource.domain}"
    end
  end
end
