def credentials( username, password )
  require 'dnsimple'
  DNSimple::Client.username = username
  DNSimple::Client.password = password
  if new_resource.test
    DNSimple::Client.base_uri = "https://test.dnsimple.com"
  end
end

action :create do
  credentials( new_resource.username, new_resource.password )

  begin
    DNSimple::Record.create( new_resource.domain,
                             new_resource.name,
                             new_resource.type,
                             new_resource.content )

    Chef::Log.info "DNSimple: created #{new_resource.type} record " +
      "for #{new_resource.name}.#{new_resource.domain}"

  rescue DNSimple::RecordExists
    Chef::Log.info "DNSimple record already exists"
  end
end

action :destroy do
  credentials( new_resource.username, new_resource.password )

  records = DNSimple::Record.all( new_resource.domain )

  records.delete_if {|r| r.name != new_resource.name } unless new_resource.name.nil?
  records.delete_if {|r| r.record_type != new_resource.type } unless new_resource.type.nil?
  records.delete_if {|r| r.content != new_resource.content } unless new_resource.content.nil?

  records.each do |record|
    record.destroy
    Chef::Log.info "DNSimple: destroyed #{new_resource.type} record " +
      "for #{new_resource.name}.#{new_resource.domain}"
  end
end
