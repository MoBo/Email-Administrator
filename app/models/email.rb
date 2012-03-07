class Email < ActiveRecord::Base
  attr_accessible :address, :password, :comment, :expires, :path, :forward_email, :receive, :alt_email
end
