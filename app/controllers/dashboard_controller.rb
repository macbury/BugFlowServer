class DashboardController < ApplicationController

  def report
    @project = Project.find_by_secret(params[:api_key])
    @project.import(params)
    render nothing: true
  end

end
