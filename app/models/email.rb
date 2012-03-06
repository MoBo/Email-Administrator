class Email < ActiveRecord::Base
  attr_accessible :address, :password, :comment, :expires, :path, :foward_email, :receive, :alt_email    
end
