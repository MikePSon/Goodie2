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
    @all_cycles = Cycle.where(:project_id => @project.id)
    @thisPage = "SHOWPROJECT"
    @title = @project.name
    @subtitle = @project.mission

    if (current_user.program_admin || current_user.admin ) && @all_cycles.count > 0
      @primaryAction = true
      @primaryActionText = "Edit Project <i class='icon-settings' style='margin-left:3px;'></i>"
      @primaryActionPath = edit_project_path(@project)

      @all_applicants = User.where(:organization_id => current_user.organization_id.to_s).where(:applicant => true)
      @all_requests = Request.where(:project_id => @project.id)
      @all_awarded = @all_requests.where(:accepted => true)

      @average_applications = (@all_requests.count / @all_cycles.count).round(0)
      @average_awards = (@all_awarded.count / @all_cycles.count).round(0)

      @has_open_cycle = false
      @amount_given = 0.0
      @all_cycles.each do |this_cycle|
        if this_cycle.status =="Open"
          @has_open_cycle = true
        end #has_open_cycle check
      end #End Cycle Loop

      @all_awarded.each do |this_request|
        @amount_given += this_request.amount_awarded
      end

      # Demographics
      @male_applicants = @all_applicants.where(:gender => "Male").count
      @female_applicants = @all_applicants.where(:gender => "Female").count
      @other_gender_applicants = @all_applicants.where(:gender => "Other").count
      @decline_gender_applicants = @all_applicants.where(:gender => "Prefer not to say").count
      
      @applicants_18_under = @all_applicants.where(:age.lte => 18).count
      @applicants_18_to_24 = @all_applicants.where(:age.gte => 19).where(:age.lte => 24).count
      @applicants_25_to_29 = @all_applicants.where(:age.gte => 25).where(:age.lte => 29).count 
      @applicants_30_to_39 = @all_applicants.where(:age.gte => 30).where(:age.lte => 39).count 
      @applicants_40_to_49 = @all_applicants.where(:age.gte => 40).where(:age.lte => 49).count 
      @applicants_50_to_59 = @all_applicants.where(:age.gte => 50).where(:age.lte => 59).count
      @applicants_60_to_69 = @all_applicants.where(:age.gte => 60).where(:age.lte => 69).count
      @applicants_70_plus  = @all_applicants.where(:age.gte => 70).count

      @white_applicants = @all_applicants.where(:race => "White").count
      @hispanic_applicants = @all_applicants.where(:race => 'Hispanic, Latino, Spanish Origin').count
      @black_applicants = @all_applicants.where(:race => 'Black or African American').count
      @native_american_applicants = @all_applicants.where(:race => 'American Indian, Alaska Native').count
      @middle_eastern_applicants = @all_applicants.where(:race => 'Middle Eastern, North African').count
      @hawaiian_applicants = @all_applicants.where(:race => 'Native Hawaiian, Pacific Islander').count
      @two_race_applicants = @all_applicants.where(:race => 'Two or more races').count
      @other_race_applicants = @all_applicants.where(:race => 'Other').count

    end #End program admin view
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
        format.html { redirect_to @project }
        format.json { render :index, status: :created, location: @project }
        flash[:success] = "Project successfully created!"
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        flash[:danger] = "Whoops! There was an error."
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
