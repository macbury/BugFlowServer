class V1::SyncController < ApplicationController
  def sync
   	@project = Project.find_by_secret(params[:api_key])
	@project.import(params[:data])
	render nothing: true
  end
end
