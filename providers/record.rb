require 'dnsimple'

def credentials( username, password )
  DNSimple::Client.username = username
  DNSimple::Client.password = password
end


action :create do
  credentials( new_resource.username, new_resource.password )

  begin
    DNSimple::Record.create( new_resource.domain,
                             new_resource.name,
                             new_resource.type,
                             new_resource.content )
    Chef::Log.info "DNSimple creating #{new_resource.type} record " +
      "for #{new_resource.name}.#{new_resource.domain}"
  rescue DNSimple::RecordExists
    Chef::Log.info "DNSimple record already exists"
  end
end
