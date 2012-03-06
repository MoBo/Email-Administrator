class User < ActiveRecord::Base
  attr_accessible :name, :email, :group_id
  validates :name, presence: true, length: {maximum: 50}
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }
  #releations
  belongs_to :group
  has_one :project, :through => :group

  #validates_presence_of :group

  #scopes
  scope :without_group, where(:group_id => nil)
  scope :with_group, where('group_id is not null')
end
