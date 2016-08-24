class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    myOrg = current_user.organization_id
    @projects = Project.where(:organization_id => myOrg)
    @thisPage = "PROJECT"
    @title = "Projects"
    @subtitle = "All of your projects"
    @primaryAction = true
    @primaryActionText = "New Project!"
    @primaryActionPath = new_project_path
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @cycles = Cycle.where(:project_id => @project.id)
    @thisPage = "PROJECT"
    @title = @project.name
    @subtitle = @project.mission
    @primaryAction = true
    @primaryActionText = "Edit Project <i class='icon-settings' style='margin-left:3px;'></i>"
    @primaryActionPath = edit_project_path(@project)
  end

  # GET /projects/new
  def new
    @project = Project.new
    @thisPage = "PROJECT"
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
        question_attributes: [ :label, :id, :_destroy ],
        cycle_attributes: [ :name, :id, :_destroy ]
        )
    end
end
