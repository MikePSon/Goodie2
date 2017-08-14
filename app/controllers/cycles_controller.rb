class CyclesController < ApplicationController
  before_action :set_cycle, only: [:show, :edit, :update, :destroy]

  # GET /cycles
  # GET /cycles.json
  def index
    if current_user.admin?
      @cycles = Cycle.all
    else
      @cycles = Cycle.where(:organization_id => current_user.organization_id)
    end
  end

  # GET /cycles/1
  # GET /cycles/1.json
  def show
    @questions = Question.where(:cycle_id => @cycle.id)
    @all_requests = Request.where(:cycle_id => @cycle.id)

    @title = @cycle.name
    @subtitle = @all_requests.count.to_s + " Applications"
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
    @cycle[:is_cycle] = true
    @cycle[:is_project] = false
    @cycle[:created_at] = DateTime.now

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
      params.require(:cycle).permit(:name, :status, :open, :close, 
        :budget, :project_id, :organization_id, :is_cycle, :is_project,
        questions_attributes: [:label, :type, :question_matcher, :id])
    end
end
