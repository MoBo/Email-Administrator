class Email < ActiveRecord::Base
  
  devise :database_authenticatable, :recoverable
  attr_accessible :email, :password, :password_confirmation, :comment, :expires, :email_path_id, :forward_email, :receive, :alt_email, :reminder_send, :active
  
  belongs_to :email_path
  # before_save :encrypt_password
  
 
  
  #static methods
  def self.get_emails_expires_soon
    Email.where(:expires => (Time.now)..(Time.now + 14.days), :reminder_send => false)
  end
  
  def self.get_emails_expired
    Email.where("expires >= ? and active = ?",Time.now,true)
  end
 
  def set_reminder_send(value)
    self.update_attributes(:reminder_send => value)
  end
  
  def deactivate
    self.update_attributes(:active => false)
  end
  
  def self.search(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  private
  
  # def encrypt_password
    # self.password = BCrypt::Password.create(self.password)
  # end
  
  # test password
  def is_authenticated(passw_hash)
     self.password.eql?  BCrypt::Password.new(passw_hash)
  end
end
