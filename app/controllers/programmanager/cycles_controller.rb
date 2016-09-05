class Programadmin::CyclesController < ApplicationController
	before_filter :require_programadmin!
  before_action :set_cycle, only: [:show, :edit, :update, :destroy]

  def index
    @thisPage = "CYCLES"
    @title = "Project cycles"
    @subtitle = "Your grant cycles"

    @primaryAction = true
    @primaryActionText = "New Cycle!"
    @primaryActionPath = new_programadmin_cycle_path

    yourOrgID = current_user.organization_id

    @yourOrg = Organization.where(:id => yourOrgID).first
    @yourProjects = Project.where(:organization_id => yourOrgID)

    @planningCycles = Cycle.where(:project_id => @yourProjects).where(:cyclestatus => 1)
    @upcomingCycles = Cycle.where(:project_id => @yourProjects).where(:cyclestatus => 2)
    @openCycles = Cycle.where(:project_id => @yourProjects).where(:cyclestatus => 3)
    @closedCycles = Cycle.where(:project_id => @yourProjects).where(:cyclestatus => 4)
    @reopenedCycles = Cycle.where(:project_id => @yourProjects).where(:cyclestatus => 5)
  end

  def new
  	@thisPage = "CYCLES"
    @title = "New project cycle"
    @subtitle = "Give some new money"

    @cycle = Cycle.new

    yourOrgID = current_user.organization_id
	  @yourProjects = Project.where(:organization_id => current_user.organization_id)
  end

  def show
    @thisPage = "CYCLES"
    @title = @cycle.name
    @subtitle = @cycle.quickhit

    @primaryAction = true
    @primaryActionText = "Edit cycle <i class='icon-settings' style='margin-left:3px;'></i>"
    @primaryActionPath = edit_programadmin_cycle_path(@cycle)
  end

  def edit
    @thisPage = "CYCLES"
    @title = "Edit: " + @cycle.name
    @subtitle = @cycle.quickhit
  end

  
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
      params.require(:cycle).permit(:name, :description, :start, :close, :project_id, :cyclestatus_id)
    end



end
