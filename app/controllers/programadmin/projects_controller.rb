class Programadmin::ProjectsController < ApplicationController
	before_filter :require_programadmin!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @thisPage = "PROJECT"
    @title = "Projects"
    @subtitle = "All of your projects"

    @yourOrganization = Organization.where(:id => current_user.organization_id)
    @yourProjects = Project.where(:organization_id => @yourOrganization)

    @primaryAction = true
    @primaryActionText = "New Project!"
    @primaryActionPath = new_programadmin_project_path
  end

  def new
    @thisPage = "PROJECT"
    @title = "New Project"
    @subtitle = "Create a new grant project here!"

    @project = Project.new
  end

  def show
    @thisPage = "PROJECT"
    @title = @project.name
    @subtitle = @project.quickhit

    @primaryAction = true
    @primaryActionText = "Edit Project <i class='icon-settings' style='margin-left:3px;'></i>"
    @primaryActionPath = edit_programadmin_project_path(@project)
  end

  def edit
    @thisPage = "PROJECT"
    @title = "Edit: " + @project.name
    @subtitle = @project.quickhit
  end


  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:organization_id, :name)
    end
end
