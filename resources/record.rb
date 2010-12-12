actions :create, :destroy

attribute :domain,   :kind_of => String
attribute :name,     :kind_of => String
attribute :type,     :kind_of => String
attribute :content,  :kind_of => String
attribute :username, :kind_of => String
attribute :password, :kind_of => String
attribute :test,     :default => false
