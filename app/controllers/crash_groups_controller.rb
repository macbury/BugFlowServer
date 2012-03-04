class CrashGroupsController < ApplicationController
  http_basic_authenticate_with :name => "bury", :password => "bury"
  before_filter :preload_resource!

  def index
    @groups = @current_project.crash_groups
  end

  def show
    @group = @current_project.crash_groups.find(params[:id])
    @crashes = @group.crashes.order("created_at DESC").limit(15)
  end

  protected
    def preload_resource!
      @current_project = Project.find(params[:project_id])
    end
end
