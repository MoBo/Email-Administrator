class Email < ActiveRecord::Base
  
  devise :database_authenticatable, :recoverable
  attr_accessible :email, :password, :password_confirmation, :comment, :expires, :path, :forward_email, :receive, :alt_email
  
  # before_save :encrypt_password
  private
  
  # def encrypt_password
    # self.password = BCrypt::Password.create(self.password)
  # end
  
  # test password
  def is_authenticated(passw_hash)
     self.password.eql?  BCrypt::Password.new(passw_hash)
  end
end
