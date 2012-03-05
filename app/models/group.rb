class Group < ActiveRecord::Base
	has_many :users
	belongs_to :project

	validates_presence_of :users
end
