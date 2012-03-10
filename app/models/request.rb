class Request < ActiveRecord::Base
	belongs_to :group
	validates :params, :format, :method, :path, :request_time, :start_time, :env, :cpu, :ram, presence: true

	serialize :params
	serialize :env
end
