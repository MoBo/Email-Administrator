class Domain < ActiveRecord::Base
  attr_accessible :name
  
  has_many :domains
end
