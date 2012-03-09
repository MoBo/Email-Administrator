class EmailPath < ActiveRecord::Base
  
  attr_accessible :type, :path
  
  has_many :emails
  
end
