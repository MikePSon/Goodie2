class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :require_noapplicant!
  before_filter :only => :show do |this_project|
    if !current_user.admin?
      this_project.require_myproject(params[:id])
    end
  end

  # GET /projects
  # GET /projects.json
  def index
    @thisPage = "PROJECT"

    if current_user.admin?
      @primaryAction = true
      @primaryActionText = "New Project!"
      @primaryActionPath = new_project_path
      @projects = Project.all
    end #End Sysadmin functions

    if current_user.program_admin? || current_user.program_manager?
      @myOrg = Organization.where(:id => current_user.organization_id.to_s).first
      @projects = Project.where(:organization_id => @myOrg.id)
      submittedRequests = Request.where(:organization_id => current_user.organization_id).where(:app_complete => true)

      if current_user.program_admin?
        @primaryAction = true
        @primaryActionText = "New Project!"
        @primaryActionPath = new_project_path
      end #End Program Admin

      if current_user.program_manager?
        if @myOrg.manager_project_edit?
          @primaryAction = true
          @primaryActionText = "New Project!"
          @primaryActionPath = new_project_path
        end
      end #End Program Manager
    end #End nonsys admin functions
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @cycles = Cycle.where(:project_id => @project.id)
    @thisPage = "SHOWPROJECT"
    @title = @project.name
    @subtitle = @project.mission

    if current_user.program_admin || current_user.admin
      @primaryAction = true
      @primaryActionText = "Edit Project <i class='icon-settings' style='margin-left:3px;'></i>"
      @primaryActionPath = edit_project_path(@project)
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    @thisPage = "NEWPROJECT"
    @title = "New Project"
    @subtitle = "Create a new grant project here!"
  end

  # GET /projects/1/edit
  def edit
    @thisPage = "PROJECT"
    @title = "Edit: " + @project.name
    @subtitle = @project.mission
  end

  # POST /projects
  # POST /projects.json
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

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(
        :name,
        :organization_id,
        :mission,
        :repeat_type,
        :cycle_budget,
        cycle_attributes: [ :name, :id, :_destroy ]
        )
    end
end
