class Group < ActiveRecord::Base
	belongs_to :project
	has_many :requests, dependent: :delete_all
	validates :location, :controller, :action, presence: true
end
