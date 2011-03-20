actions :create, :destroy

attribute :domain,   :kind_of => String
attribute :name,     :kind_of => String
attribute :type,     :kind_of => String
attribute :content,  :kind_of => String
attribute :ttl,      :kind_of => Integer, :default => 3600
attribute :priority, :kind_of => Integer
attribute :username, :kind_of => String
attribute :password, :kind_of => String
attribute :test,     :default => false
