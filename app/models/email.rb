class Email < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :lockable

  attr_accessible :email, :password, :password_confirmation, :comment, :expires_on, :email_path, :forwards, :alt_email, :reminder_sent, :active, :domain_id, :last_activity_on, :admin, :can_receive, :can_send
  belongs_to :domain

  validates :email, :presence => true ,:format => { :with => /^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$/i,
    :message => "%{value} has invalid format" }
  validates :password, :presence => {:message => 'Password cannot be blank'}, :if => :password_validation_required?
  validates :email_path, :presence => true
  validates :domain_id, :presence => {:message => 'Domain cannot be blank'}
  validates_associated :domain

  validates :alt_email, :format => { :with => /^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$/i,
    :message => "Alternative email: %{value} has invalid format" },:allow_blank => true, :allow_nil => true
    
  before_validation :convert_email
  
  
  #static methods
  def self.get_emails_expires_soon
    Email.where(:expires_on => (Time.now)..(Time.now + 14.days), :reminder_sent => false)
  end
  
  def self.get_emails_expired
    Email.where("expires_on >= ? and active = ?",Time.now,true)
  end
 
  def set_reminder_sent(value)
    self.update_attributes(:reminder_sent => value)
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
    update_attribute(:email ,get_email_prefix(self[:email]) + "@" + value.name)
  end
  
  # def email=(value) 
    # value = value + '@' + Domain.find(self.domain_id).name
    # write_attribute(:email, value)
  # end
  
  def send_unlock_instructions
    EmailMailer.expires_email(self).deliver
  end
  
  def send_reset_password_instructions
    generate_reset_password_token! if should_generate_reset_token?
    EmailMailer.reset_password_instructions(self).deliver
  end
  
  def password_salt=(password_salt)
  end

  def password_salt
  end

  def password_digest(password)
    password.crypt("2a")
  end
  
  alias :devise_valid_password? :valid_password?
  def valid_password?(password)
    if self.admin
      begin
        devise_valid_password?(password)
      rescue BCrypt::Errors::InvalidHash
        password.crypt(encrypted_password[0..2]) == encrypted_password
      end
    end
  end

  def forwards
    forward_email.try(:split, " ") || []
  end

  def forwards=(array_or_string)
    array_or_string = array_or_string.split(/\s+/) if array_or_string.is_a? String

    self.forward_email = array_or_string.map(&:downcase).uniq.join(" ")
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
  
  def get_email_prefix(email)
    email.sub(/@.*/,"")
  end
end
