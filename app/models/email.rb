class Email < ActiveRecord::Base
  
  devise :recoverable
  attr_accessible :address, :password, :comment, :expires, :path, :forward_email, :receive, :alt_email, :password_reset_id
  
  before_save :encrypt_password
  has_one :password_reset
  
  
  def email
    self.address
  end
  
  private
  
  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end
  
  # test password
  def is_authenticated(passw_hash)
     self.password.eql?  BCrypt::Password.new(passw_hash)
  end
end
