class EmailPath < ActiveRecord::Base
  
  attr_accessible :path_type, :path
  
  has_many :emails
  
  validates :path_type, :presence => true
  validates :path, :presence => true
  
end
