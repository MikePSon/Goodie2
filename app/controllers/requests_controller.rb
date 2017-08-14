class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.where(:organization_id => current_user.organization_id)
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @cycle_questions = Question.where(:cycle_id => @request.cycle_id)
    @project_questions = Question.where(:project_id => @request.project_id)
  end

  # GET /requests/new
  def new
    @request = Request.new

    if params[:cycle_id]
      @cycle_questions = Question.where(:cycle_id => params[:cycle_id]);
      @cycleID = params[:cycle_id]
    else
      @cycle_questions = Question.where(:cycle_id => @request.cycle_id);
    end
    if params[:project_id]
      @project_questions = Question.where(:project_id => params[:project_id]);
      @projectID = params[:project_id]
    else
      @project_questions = Question.where(:project_id => @request.project_id);
    end

  end

  # GET /requests/1/edit
  def edit
    if params[:cycle_id]
      @cycle_questions = Question.where(:cycle_id => params[:cycle_id]);
      @cycleID = params[:cycle_id]
    else
      @cycle_questions = Question.where(:cycle_id => @request.cycle_id);
    end
    if params[:project_id]
      @project_questions = Question.where(:project_id => params[:project_id]);
      @projectID = params[:project_id]
    else
      @project_questions = Question.where(:project_id => @request.project_id);
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
      params.require(:request).permit(:name, :cycle, :project_id, :organization_id,
        :project_string_1, :project_string_2, :project_string_3, :project_string_4, :project_string_5, :project_string_6, :project_string_7, :project_string_8, :project_string_9, :project_string_10,
        :project_boolean_1, :project_boolean_2, :project_boolean_3, :project_boolean_4, :project_boolean_5, :project_boolean_6, :project_boolean_7, :project_boolean_8, :project_boolean_9, :project_boolean_10,
        :project_date_1, :project_date_2, :project_date_3, :project_date_4, :project_date_5, :project_date_6, :project_date_7, :project_date_8, :project_date_9, :project_date_10,
        :project_datetime_1, :project_datetime_2, :project_datetime_3, :project_datetime_4, :project_datetime_5, :project_datetime_6, :project_datetime_7, :project_datetime_8, :project_datetime_9, :project_datetime_10,
        :project_time_1, :project_time_2, :project_time_3, :project_time_4, :project_time_5, :project_time_6, :project_time_7, :project_time_8, :project_time_9, :project_time_10,
        :project_integer_1, :project_integer_2, :project_integer_3, :project_integer_4, :project_integer_5, :project_integer_6, :project_integer_7, :project_integer_8, :project_integer_9, :project_integer_10,
        :project_float_1, :project_float_2, :project_float_3, :project_float_4, :project_float_5, :project_float_6, :project_float_7, :project_float_8, :project_float_9, :project_float_10,

        :cycle_string_1, :cycle_string_2, :cycle_string_3, :cycle_string_4, :cycle_string_5, :cycle_string_6, :cycle_string_7, :cycle_string_8, :cycle_string_9, :cycle_string_10,
        :cycle_boolean_1, :cycle_boolean_2, :cycle_boolean_3, :cycle_boolean_4, :cycle_boolean_5, :cycle_boolean_6, :cycle_boolean_7, :cycle_boolean_8, :cycle_boolean_9, :cycle_boolean_10,
        :cycle_date_1, :cycle_date_2, :cycle_date_3, :cycle_date_4, :cycle_date_5, :cycle_date_6, :cycle_date_7, :cycle_date_8, :cycle_date_9, :cycle_date_10,
        :cycle_datetime_1, :cycle_datetime_2, :cycle_datetime_3, :cycle_datetime_4, :cycle_datetime_5, :cycle_datetime_6, :cycle_datetime_7, :cycle_datetime_8, :cycle_datetime_9, :cycle_datetime_10,
        :cycle_time_1, :cycle_time_2, :cycle_time_3, :cycle_time_4, :cycle_time_5, :cycle_time_6, :cycle_time_7, :cycle_time_8, :cycle_time_9, :cycle_time_10,
        :cycle_integer_1, :cycle_integer_2, :cycle_integer_3, :cycle_integer_4, :cycle_integer_5, :cycle_integer_6, :cycle_integer_7, :cycle_integer_8, :cycle_integer_9, :cycle_integer_10,
        :cycle_float_1, :cycle_float_2, :cycle_float_3, :cycle_float_4, :cycle_float_5, :cycle_float_6, :cycle_float_7, :cycle_float_8, :cycle_float_9, :cycle_float_10
      )
    end
end
