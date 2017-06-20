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
      @organizations = Organization.all
      @thisPage = "ADMINORGANIZATION"
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
    
    @profile_complete = get_completion_rate(@organization)
    if @profile_complete < 59
      @complete_color = "danger"
    elsif @profile_complete <79
      @complete_color = "warning"
    elsif @profile_complete < 95
      @complete_color = "info"
    else
      @complete_color = "success"
    end

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
    @organizationRequests = Request.where(:organization_id => @organization.id.to_s)
    @organizationProjects = Project.where(:organization_id => @organization.id.to_s)
    @awarded_requests = @organizationRequests.where(:accepted => true)
    @organizationTeam = User.where(:organization_id => @organization.id).where(:applicant => false)
    @openCycles = Cycle.where(:organization_id => @organization.id).where(:status => "Open")

    @total_amount_awarded = 0.0
    @awarded_requests.each do |this_request|
      @total_amount_awarded += this_request.amount_awarded
    end


    @timelineItems = get_timeline(@organization)
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    @thisPage = "EDITORGANIZATION"
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
        format.html { redirect_to @organization }
        format.json { render :show, status: :ok, location: @organization }
        flash[:success] = "Organization was successfully updated."
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
        :url,
        :logo,
        :address_1, :address_2, :city, :state, :zip, 
        :manager_decision,
        :manager_project_edit,
        :annual_giving_goal,
        :created_by)
    end

    def create_admin_user
      thisUser = User.where(:id => @organization.created_by).first
      thisUser.update(organization_id: @organization.id)
    end

    def get_completion_rate(org)
      net_amt = 0.0

      if !org.name.blank?
        net_amt += 1
      end
      if !org.motto.blank?
        net_amt += 1
      end
      if !org.url.blank?
        net_amt += 1
      end
      if !org.address_1.blank?
        net_amt += 1
      end
      if !org.city.blank?
        net_amt += 1
      end
      if !org.state.blank?
        net_amt += 1
      end
      if !org.zip.blank?
        net_amt += 1
      end
      if !org.annual_giving_goal.blank?
        net_amt += 1
      end
      rate = (net_amt / 8.0)*100
      return rate
    end
end
