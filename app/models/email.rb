class Email < ActiveRecord::Base  
  
  
  devise :database_authenticatable, :recoverable
  attr_accessible :email, :password, :password_confirmation, :comment, :expires, :email_path_id, :forward_email, :receive, :alt_email, :reminder_send, :active, :domain_id
  
  belongs_to :email_path
  belongs_to :domain

    
  validates :email, :presence => true ,:format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => "%{value} has invalid format" }
  validates :password, :presence => true
  validates :email_path_id, :presence => true
  validates :domain_id, :presence => true
  before_validation :convert_email
  
 
  
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
  
  public
  
  def domain=(value)
    write_attribute(:domain_id , value.id)
    write_attribute( :email ,get_email_prefix(self[:email]) + "@" + value.name)
  end
  
  # def email=(value) 
    # value = value + '@' + Domain.find(self.domain_id).name
    # write_attribute(:email, value)
  # end
  
  def convert_email
    domain_value = Domain.find(self.domain_id).name
    # if not self.email =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    value = self.email + '@' + domain_value
    # else
      # value = get_email_prefix(self.email) + "@" + domain_value  
    # end
    write_attribute(:email, value)
  end
  
    
  def addForwardEmail(value)
    #check if value already exists
    if not (self.forward_email.downcase.include? value)
      self.forward_email +=" " + value
    else
    end       
  end
  
  def removeForwardEmail(value)
    #check the value if it can be sliced
    self.forward_email.slice! value.to_s
  end
  
  private
  
  # def encrypt_password
    # self.password = BCrypt::Password.create(self.password)
  # end
  
  # test password
  def is_authenticated(passw_hash)
     self.password.eql?  BCrypt::Password.new(passw_hash)
  end
  
  def get_email_prefix(email)
    email.sub(/@.*/,"")
  end
end
