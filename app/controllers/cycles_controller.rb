class CyclesController < ApplicationController
  before_action :set_cycle, only: [:show, :edit, :update, :destroy]
  before_filter :require_noapplicant!
  before_filter :only => :show do |this_cycle|
    if !current_user.admin?
      this_cycle.require_mycycle(params[:id])
    end
  end

  # GET /cycles
  # GET /cycles.json
  def index
    @cycles = Cycle.all
    @thisPage = "CYCLES"
    @title = "Your Cycles"
    @subtitle = "All of your Cycles"

    @primaryAction = true
    @primaryActionText = "New cycle!"
    @primaryActionPath = new_cycle_path

    @yourCycles = Cycle.where(:organization_id => current_user.organization_id.to_s);
  end

  # GET /cycles/1
  # GET /cycles/1.json
  def show
    @project = @cycle.project
    @allRequests = Request.where(:cycle_id => @cycle.id.to_s)
    @createdRequests = @allRequests.where(:status => "Created")
    @submittedRequests = @allRequests.where(:status => "Submitted")
    @incompleteRequests = @allRequests.where(:status => "Incomplete")
    @reopenedRequests = @allRequests.where(:status => "Re-Opened")
    @underReviewRequests = @allRequests.where(:status => "Under Review")
    @closedRequests = @allRequests.where(:status => "Closed")
    @awardedRequests = @allRequests.where(:accepted => true)
    @paymentRequests = @allRequests.where(:status => "Payment")
    @projectCompleteRequests = @allRequests.where(:status => "Project Complete")

    @applicants = Array.new
    @allRequests.each do |thisReq|
      @applicants << User.where(:id => thisReq.user_id).first
    end



    @thisPage = "NULL"
    @title = @cycle.name
    @subtitle = @cycle.project.name

    if @cycle.status == "Planned"
      @primaryAction = true
      @primaryActionText = "Edit Cycle"
      @primaryActionPath = edit_cycle_path(@cycle)
    end

    if @cycle.status == "Open"
      @created_incomplete = @createdRequests
    else
      @created_incomplete = @incompleteRequests
    end

    if @cycle.status == "Closed" && (current_user.program_admin? || current_user.program_manager?)
      if @underReviewRequests.count > 0
        @requests_for_cycle = @underReviewRequests
      else
        @requests_for_cycle = @awardedRequests
      end

    end

    #Need to figure out DateTime Math
    @recentRequests = Request.where(:cycle_id => @cycle.id.to_s).where(submitted_date: (DateTime.now - 48.hours)..DateTime.now)

  end

  # GET /cycles/new
  def new
    @cycle = Cycle.new
    @thisPage = "CYCLES"
    @title = "New Cycle"
    @subtitle = "Create a new cycle"
  end

  # GET /cycles/1/edit
  def edit
    @thisPage = "CYCLES"
    @title = "Edit Cycle"
    @subtitle = "Make changes to your grant cycle"
  end

  # POST /cycles
  # POST /cycles.json
  def create
    cycle_params[:created_at] = DateTime.now
    @cycle = Cycle.new(cycle_params)

    respond_to do |format|
      if @cycle.save
        format.html { redirect_to @cycle, notice: 'Cycle was successfully created.' }
        format.json { render :show, status: :created, location: @cycle }
      else
        format.html { render :new }
        format.json { render json: @cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cycles/1
  # PATCH/PUT /cycles/1.json
  def update
    respond_to do |format|
      if cycle_params[:status] == "Closed"
        close_requests(@cycle)
      end
      if @cycle.update(cycle_params)
        format.html { redirect_to @cycle, notice: 'Cycle was successfully updated.' }
        format.json { render :show, status: :ok, location: @cycle }
      else
        format.html { render :edit }
        format.json { render json: @cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cycles/1
  # DELETE /cycles/1.json
  def destroy
    @cycle.destroy
    respond_to do |format|
      format.html { redirect_to cycles_url, notice: 'Cycle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cycle
      @cycle = Cycle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cycle_params
      params.require(:cycle).permit(
        :admin_note, :instructions, :name, :status, :form990, :board_members,
        :open, :close, :created_at, :one_application, :amount_requested,
        :project_summary, :begin_date, :end_date, :organization_name,
        :ein_taxID, :org_address_1, :org_address_2, :org_city, :org_state, 
        :org_zip, :org_mission, :description, :other_funding, :total_budget,
        :target_demo, :app_complete, :is_cycle, :is_project, :project_start,
        :project_end, :organization_id, :project_id)
    end

    def close_requests cycle
      puts "***** THIS IS RUNNING *****"
      requests = Request.where(:cycle_id => cycle.id.to_s)
      requests.each do |this_request|
        if this_request.app_complete?
          this_request.update(:status => "Under Review")
        else
          this_request.update(:status => "Incomplete")
        end
      end
    end
end
