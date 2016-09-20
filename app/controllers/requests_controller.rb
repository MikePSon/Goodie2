class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :get_relations, only: [:show]

  # GET /requests
  # GET /requests.json
  def index
    @thisPage = "ORGREQUESTS"
    
    if !current_user.admin || !current_user.applicant
      @thisPage = "ORGREQUESTS"
      @organization_requests = Request.where(:organization_id => current_user.organization_id.to_s)
      @all_projects = Project.where(:organization_id => current_user.organization_id.to_s)
      @planned_cycles = Cycle.where(:organization_id => current_user.organization_id.to_s).where(:status => "Planned").order(created_at: :desc)
      @open_cycles = Cycle.where(:organization_id => current_user.organization_id.to_s).where(:status => "Open").order(open: :asc)
      @closed_cycles = Cycle.where(:organization_id => current_user.organization_id.to_s).where(:status => "Closed").order(close: :desc)
    elsif current_user.applicant
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
      if current_user.applicant?
        format.html { redirect_to applicant_requests_path, notice: 'Request was successfully destroyed.' }
      else
        format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      end
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

    def get_completion_rate cycle
      requests_all = @organization_requests.where(:cycle_id => cycle.id)
      requests_incomplete = requests_all.where(:status => "Incomplete").count
      requests_all_count = requests_all.count
      completion_rate = ((requests_all_count - requests_incomplete).to_f / requests_all_count.to_f).round(2)
      completion_rate = (completion_rate * 100).to_i
      return completion_rate
    end

end
