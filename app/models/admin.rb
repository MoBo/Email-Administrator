class Admin < ActiveRecord::Base
  
  devise :database_authenticatable, :rememberable
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  
  validates :email, :presence => true ,:format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => "%{value} has invalid format" }
end
