class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_filter :require_noapplicant!
  before_filter :only => :show do |thisOrg|
    if !current_user.admin?
      thisOrg.require_myorganization(params[:id])
    end
  end
  after_action :create_admin_user, only: [:create]

  # GET /organizations
  # GET /organizations.json
  def index
    if current_user.admin?
      @test = "HELLOW"
      @organizations = Organization.all
    elsif current_user.program_admin?
      @organizations = Organization.where(:id => current_user.organization_id.to_s).first
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    #Page Standards
    @thisPage = "ORGANIZATION"
    @title = @organization.name
    @subtitle = "What are you about?"

    if current_user.program_admin?
      @primaryAction = true
      @primaryActionText = "Edit Organization <i class='icon-settings' style='margin-left:3px;'></i>"
      @primaryActionPath = edit_organization_path(@organization)
    end

    if !current_user.admin?
      @programAdmin = User.where(:organization_id => @organization.id).where(:program_admin => true).first
    else
      @programAdmin = User.where(:organization_id => @organization.id).where(:id => @organization.created_by).first
    end
    @organizationApplicants = User.where(:organization_id => @organization.id).where(:applicant => true)
    @organizationRequests = Request.where(:organization_id => @organization.id)
    @organizationProjects = Project.where(:organization_id => @organization.id)
    @organizationTeam = User.where(:organization_id => @organization.id).where(:applicant => false)
    @openCycles = Cycle.where(:organization_id => @organization.id).where(:status => "Open")

    @totalAmountAwarded = @organizationRequests.sum(:amount_awarded)

    @timelineItems = get_timeline(@organization)
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)


    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def get_timeline this_organization

    opened_cycles = Cycle.where(:organization_id => current_user.organization_id).where(open: (Time.now..(Time.now + 24.hours)))
    closing_cycles = Cycle.where(:organization_id => current_user.organization_id).where(close: (Time.now - 24.hours)..Time.now)
    new_projects = Project.where(:organization_id => current_user.organization_id).order(created_at: :desc).limit(5)

    @timeline = []

    if opened_cycles.count > 0
      opened_cycles.each do |this_cycle|
        @timeline << this_cycle
      end
    end
    if closing_cycles.count > 0
      closing_cycles.each do |this_cycle|
        @timeline << this_cycle
      end
    end
    if new_projects.count > 0
      new_projects.each do |thisProject|
        @timeline << thisProject
      end
    end
    @timeline.sort_by{|e| e[:created_at]}

    return @timeline
  end 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(
        :name,
        :motto,
        :manager_decision,
        :manager_project_edit,
        :created_by)
    end

    def create_admin_user
      thisUser = User.where(:id => @organization.created_by).first
      thisUser.update(organization_id: @organization.id)
    end
end
