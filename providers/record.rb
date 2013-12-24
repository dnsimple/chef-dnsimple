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

include DNSimple::Connection

action :create do
  domain =  new_resource.domain
  name =    new_resource.name
  content = new_resource.content
  type =    new_resource.type
  ttl =     new_resource.ttl

  zone = dnsimple.zones.get( domain )

  zone.records.all.each do |r|
    Chef::Log.debug "Checking if #{name} exists as #{content} and #{ttl}"
    # do nothing if the record already exists, same content and type
    break if ((r.name == name) &&
             (r.value == content) &&
             (r.ttl == ttl) &&
             (r.type == type))

    # delete any record with the name and type we're trying to create
    if ((r.name == name) && (r.type == type))
      Chef::Log.debug "Cannot modify a record, must destroy #{name} first"
      r.destroy
    end
  end

  begin
    Chef::Log.debug "Attempting to create record type #{type} for #{name} as #{content} with type #{type}"
    record = zone.records.create( :name => name,
                                  :value => content,
                                  :type => type,
                                  :ttl => ttl )
    new_resource.updated_by_last_action(true)
    Chef::Log.info "DNSimple: created #{type} record for #{name}.#{domain}"
  rescue Excon::Errors::UnprocessableEntity
    Chef::Log.debug "DNSimple: #{name}.#{domain} already exists, moving on"
  end
end

action :destroy do
  zone = dnsimple.zones.get( new_resource.domain )

  zone.records.all.each do |r|
    if ( r.name == new_resource.name ) and ( r.type == new_resource.type )
      r.destroy
      new_resource.updated_by_last_action(true)
      Chef::Log.info "DNSimple: destroyed #{new_resource.type} record " +
        "for #{new_resource.name}.#{new_resource.domain}"
    end
  end
end