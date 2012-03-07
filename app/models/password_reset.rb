class PasswordReset < ActiveRecord::Base
  attr_accessible :reset_token
  belongs_to :email
end