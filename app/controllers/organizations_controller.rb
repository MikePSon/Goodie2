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
    @title = @organization.name
    
    @primaryAction = true
    @primaryActionText = "Edit organization!"
    @primaryActionPath = edit_organization_path(@organization)

    @organization_admin = User.where(:organization_id => @organization.id).where(:program_admin => true).first
    @all_requests = Request.where(:organization_id => @organization.id)
    @all_cycles = Cycle.where(:organization_id => @organization.id)
      @open_cycles = @all_cycles.where(:status => "Open")
      @closed_cycles = @all_cycles.where(:status => "Closed")
    
    @all_projects = Project.where(:organization_id => @organization.id)

    @all_applicants = User.where(:organization_id => @organization.id).where(:applicant => true)

    @timeline_items = get_timeline_items(@all_cycles, @all_projects)
    
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @thisPage ="NEWORGANIZATION"
  end

  # GET /organizations/1/edit
  def edit
    @thisPage = "EDITORGANIZATION"
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    raw_url = set_applicant_url(@organization)

    api = Rebrandly::Api.new

    if Rails.env.Staging?
      my_domain = api.domains.last
    else
      my_domain = api.domains.first
    end
    
    title = @organization.name

    applicant_url = api.shorten(raw_url, domain: my_domain.to_h, title: @organization.name)
    url = applicant_url.short_url
    rebrand_id = applicant_url.id


    @organization.applicant_url = url
    @organization.rebrandly_id = rebrand_id


    respond_to do |format|
      if @organization.save
        if current_user.program_admin?
          format.html { redirect_to programadmin_dash_path}
          flash[:success] = 'Organization was successfully created.' 
        else
          format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        end
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
        :custom_terms,
        :terms_conditions,
        :applicant_url,
        :rebrandly_id,
        :created_by)
    end

    def create_admin_user
      thisUser = User.where(:id => @organization.created_by).first
      thisUser.update(organization_id: @organization.id)
    end

    def set_applicant_url(org)
      if Rails.env.production?
        return "http://applicant.goodie2.com/new_applicant?organization_id=" + org.id.to_s
      else
        return "http://localhost:3000/new_applicant?organization_id=" + org.id.to_s
      end
    end

    def get_timeline_items(cycles, projects)
      @test = "HELLO"
      timelineitems = []

      
      # Cycle created
      cycles.each do |this_cycle|
        timelineitems << this_cycle
      end
      # Cycle open
      # Cycle closed
      # Project created
      projects.each do |this_project|
        timelineitems << this_project
      end

      timelineitems.sort_by{|e| e[:created_at]}

      return timelineitems
    end
end
