class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :get_relations, only: [:show]

  # GET /requests
  # GET /requests.json
  def index
    @orgCycles = Cycle.where(:organization_id => current_user.organization_id)
    @yourStartedRequests = Request.where(:user_id => current_user.id.to_s).where(:status => "Created")
    @yourRequests = Request.where(:user_id => current_user.id.to_s)
    @yourOrg = Organization.where(:id => current_user.organization_id.to_s).first

    @totalApplicants = User.where(:organization_id => current_user.organization_id).where(:applicant => true).count
    @openCycles = Cycle.where(:organization_id => current_user.organization_id).where(:status => "Open")
    @plannedCycles = Cycle.where(:organization_id => current_user.organization_id).where(:status => "Planned")

    #All Views
    @requests = Request.all

    #Program Admin
    if current_user.program_admin?
      @thisPage = "REQUEST"
      @title = "Requests"
      @subtitle = "Requests for " + @yourOrg.name
      @primaryAction = true
      if @yourRequests.count == 0
        @primaryActionText = "New Request"
        @primaryActionPath = new_request_path
      else
        @primaryActionText = "Your cycles"
        @primaryActionPath = cycles_path
      end

      @all_cycles = Cycle.where(:organization_id => current_user.organization_id)
      @open_cycles = @all_cycles.where(:status => "Open")
      @closed_cycles = @all_cycles.where(:status => "Closed")
    end

    if current_user.program_manager || current_user.applicant?
      @thisPage = "REQUEST"
      @title = "Your requests"
      @subtitle = "All requests"
    end


    if current_user.applicant? && @yourRequests.count == 0 && @openCycles.count > 0
      @primaryAction = true
      @primaryActionText = "New Request!"
      @primaryActionPath = new_request_path
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @thisPage = "REQUEST"
    if @request.title != ""
      @title = @request.title.to_s
    else
      @title = "Your Request"
    end
    if @request.summary != ""
      @subtitle = @request.summary.to_s
    else
      @subtitle = "Edit this request, make it awesome"
    end

    if current_user.applicant? && (@request.status == "Created" || @request.status == "Re-Opened")
      @primaryAction = true
      @primaryActionText = "Edit"
      @primaryActionPath = edit_request_path(@request)
    end
    
    if @request.status == "Submitted"
      #@rejectAction = true
    end


    if @request.status == "Under Review"
      @requestReviews = Review.where(:request_id => @request.id).where(:review_complete => true)
      mgrDecision = Organization.where(:id => @request.organization_id).first.manager_decision
      myReview = @requestReviews.where(:user_id => current_user.id)
      if myReview.count == 0
        @primaryAction = true
        @primaryActionText = "Review"
        @primaryActionPath = new_review_path #Needs to include params for review form
      elsif myReview.count == 1 && !myReview.first.review_complete
        @primaryAction = true
        @primaryActionText = "Review"
        @primaryActionPath = edit_review_path(myReview.first)
      elsif myReview.count == 1 && myReview.first.review_complete
        if (current_user.program_admin? || mgrDecision)
          @primaryAction = true
          @acceptReject = true
        end
      end
    end

  end

  # GET /requests/new
  def new
    @request = Request.new

    @primaryAction = true
    @primaryActionText = "Back"
    @primaryActionPath = requests_path

    @thisPage = "REQUEST"
    @title = "New request"
    @subtitle = "Get started on a new project!"

    @yourProjects = Project.where(:organization_id => current_user.organization_id.to_s)
    @yourOpenCycles = Cycle.where(:organization_id => current_user.organization_id.to_s).where(:status => "Open")

    if params[:cycle_id]
      @cycleID = params[:cycle_id]
    end
    if params[:project_id]
      @projectID = params[:project_id]
    end
  end

  # GET /requests/1/edit
  def edit
    @thisPage = "REQUEST"
    if @request.title != ""
      @title = "Edit: " + @request.title.to_s
    else
      @title = "Your Request"
    end
    if @request.summary != ""
      @subtitle = @request.summary.to_s
    else
      @subtitle = "Edit this request, make it awesome"
    end
    @myProject = Project.where(:id => @request.project_id).first.id
    @myCycle = Cycle.where(:id => @request.cycle_id).first.id


  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    puts "CREATED FUNCTION ABOUT TO RUN"
    isSubmitted = application_submitted(request_params)
    if isSubmitted
      @request[:status] = "Submitted"
    end

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    isSubmitted = application_submitted(request_params)
    if isSubmitted
      @request[:status] = "Submitted"
    end

    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      #To whoever fixes this, I know it's not ideal, but I'm hacking. Same thing is in reviews.
      params.require(:request).permit!
    end

    def get_relations
      @organization = Organization.where(:id => @request.organization_id).first
      @applicant = User.where(:id => @request.user_id).first
      @project = Project.where(:id => @request.project_id).first
      @cycle = Cycle.where(:id => @request.cycle_id).first
    end

    def application_submitted request
      puts "========== THE FUNCTION ACTUALLY RAN =========="
      puts '***** request.app_complete: ' + request[:app_complete].to_s + " *****"
      requestComplete = request[:app_complete]
      puts "APP_Complete: " + requestComplete.to_s

      if requestComplete == "1"
        puts "WORKS"
        return true
      else
        puts "BROKE"
        return false
      end

    end

end
