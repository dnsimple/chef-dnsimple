include DNSimple::Connection

action :create do
  domain =  new_resource.domain
  name =    new_resource.name
  content = new_resource.content
  type =    new_resource.type
  ttl =     new_resource.ttl

  zone = dnsimple.zones.get( domain )

  zone.records.all.each do |r|
    # do nothing if the record already exists
    break if(( r.name == name ) and
             ( r.ip == content ) and
             ( r.ttl == ttl ))

    # delete any record with the name we're trying to create
    r.destroy if r.name == name
  end

  begin
    record = zone.records.create( :name => name,
                                  :ip => content,
                                  :type => type,
                                  :ttl => ttl )
    Chef::Log.info "DNSimple: created #{type} record for #{name}.#{domain}"
  rescue Excon::Errors::NotAcceptable
    # record already exists. moving on.
  end
end

action :destroy do
  zone = dnsimple.zones.get( new_resource.domain )

  zone.records.all.each do |r|
    if ( r.name == new_resource.name ) and ( r.type == new_resource.type )
      r.destroy
      Chef::Log.info "DNSimple: destroyed #{new_resource.type} record " +
        "for #{new_resource.name}.#{new_resource.domain}"
    end
  end
end
