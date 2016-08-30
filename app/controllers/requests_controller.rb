class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :get_relations, only: [:show]

  # GET /requests
  # GET /requests.json
  def index
    @yourStartedRequests = Request.where(:user_id => current_user.id).where(:status => ["Created", "In Progress"])
    @yourRequests = Request.where(:user_id => current_user.id)

    @totalApplicants = User.where(:organization_id => current_user.organization_id).where(:applicant => true).count
    @openCycles = Cycle.where(:organization_id => current_user.organization_id).where(:status => "Open")
    @totalRequests = Request.where(:user_id => current_user.id).count

    @orgCycles = Cycle.where(:organization_id => current_user.organization_id)



    @thisPage = "REQUEST"
    @title = "Your Requests"
    @subtitle = "All of your requests"

    if @yourRequests.count == 0
      @primaryAction = true
      @primaryActionText = "New Request!"
      @primaryActionPath = new_request_path
    end


    @requests = Request.all
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

    @primaryAction = true
    @primaryActionText = "Edit!"
    @primaryActionPath = edit_request_path(@request)
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

  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

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
      #To whoever fixes this, I know it's not ideal, but I'm hacking...
      params.require(:request).permit!
    end

    def get_relations
      @organization = Organization.where(:id => @request.organization_id).first
      @applicant = User.where(:id => @request.user_id).first
      @project = Project.where(:id => @request.project_id).first
      @cycle = Cycle.where(:id => @request.cycle_id).first
    end

end
