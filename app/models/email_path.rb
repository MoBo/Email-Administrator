class EmailPath < ActiveRecord::Base
  
  attr_accessible :path_type, :path
  
  has_many :emails
  
end
