class CyclesController < ApplicationController
  before_action :set_cycle, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /cycles/1
  # GET /cycles/1.json
  def show
    @project = @cycle.project
    @allRequests = Request.where(:cycle_id => @cycle.id.to_s)
    @createdRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Created")
    @submittedRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Submitted")
    @incompleteRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Incomplete")
    @reopenedRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Re-Opened")
    @underReviewRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Under Review")
    @closedRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Closed")
    @awardedRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Awarded")
    @paymentRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Payment")
    @projectCompleteRequests = Request.where(:cycle_id => @cycle.id.to_s).where(:status => "Project Complete")

    @thisPage = "CYCLES"
    @title = @cycle.name
    @subtitle = @cycle.project.name

    if @cycle.status == "Open"
      @created_incomplete = @createdRequests
    else
      @created_incomplete = @incompleteRequests
    end

    #Need to figure out DateTime Math
    @recentRequests = Request.where(:cycle_id => @cycle.id.to_s).where(submitted_date: (DateTime.now - 48.hours)..DateTime.now)



  end

  # GET /cycles/new
  def new
    @cycle = Cycle.new
  end

  # GET /cycles/1/edit
  def edit
  end

  # POST /cycles
  # POST /cycles.json
  def create
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
        :name,
        :organization_id,
        :project_id,
        :status,
        :open,
        :close,
        :admin_note,
        question_attributes: [ :label, :id, :_destroy ])
    end
end
