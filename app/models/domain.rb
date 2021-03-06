class Domain < ActiveRecord::Base
  attr_accessible :name
  has_many :domains
  
  validates :name, :presence => true, :format => { :with => /^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$/i,
    :message => "%{value} has invalid format" }
    
  def count_users_of_domain
    Email.find_all_by_domain_id(self.id).count
  end
end
