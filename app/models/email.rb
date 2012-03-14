class Email < ActiveRecord::Base  
  
  
  devise :database_authenticatable, :recoverable
  attr_accessible :email, :password, :password_confirmation, :comment, :expires_on, :email_path_id, :forward_email, :receive, :alt_email, :reminder_send, :active, :domain_id
  
  belongs_to :email_path
  belongs_to :domain

    
  validates :email, :presence => true ,:format => { :with => /^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$/i,
    :message => "%{value} has invalid format" }
  validates :password, :presence => {:message => 'Password cannot be blank'}, :if => :password_validation_required?
  validates :email_path_id, :presence => {:message => 'Email path cannot be blank'}
  validates :domain_id, :presence => {:message => 'Domain cannot be blank'}
    validates_associated :domain
    validates_associated :email_path
  validates :alt_email, :format => { :with => /^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$/i,
    :message => "Alternative email: %{value} has invalid format" },:allow_blank => true, :allow_nil => true
    
  before_validation :convert_email
  
  
  #static methods
  def self.get_emails_expires_soon
    Email.where(:expires_on => (Time.now)..(Time.now + 14.days), :reminder_send => false)
  end
  
  def self.get_emails_expired
    Email.where("expires_on >= ? and active = ?",Time.now,true)
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
    update_attribute(:domain_id , value.id)
    update_attribute( :email ,get_email_prefix(self[:email]) + "@" + value.name)
  end
  
  # def email=(value) 
    # value = value + '@' + Domain.find(self.domain_id).name
    # write_attribute(:email, value)
  # end
  
  
  
  def password_salt=(password_salt)
  end

  def password_salt
  end

  def password_digest(password)
    password.crypt("2a")
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
  
  def convert_email
    domain_value = Domain.find(self.domain_id).name
    # if not self.email =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    self.email = get_email_prefix(self.email)
    self.email = self.email + '@' + domain_value
    # else
      # value = get_email_prefix(self.email) + "@" + domain_value  
    # end
    #update_attribute(:email, value)
  end
  
  def password_validation_required?
    self.encrypted_password.blank? || !self.password.blank?
  end
  
  # def encrypt_password
    # self.password = BCrypt::Password.create(self.password)
  # end
  
  # test password
  
  
  # def is_authenticated(passw_hash)
     # self.password.eql?  BCrypt::Password.new(passw_hash)
  # end
  
  def get_email_prefix(email)
    email.sub(/@.*/,"")
  end
end
