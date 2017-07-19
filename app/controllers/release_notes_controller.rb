class ReleaseNotesController < ApplicationController
  before_action :set_release_note, only: [:show, :edit, :update, :destroy]

  # GET /release_notes
  # GET /release_notes.json
  def index
    @release_notes = ReleaseNote.all.order_by(:release_date => 'desc')
    @thisPage = "RELEASENOTES"

    if current_user.admin?
      @primaryAction = true
      @primaryActionText = "New Notes"
      @primaryActionPath = new_release_note_path
    end
  end

  # GET /release_notes/1
  # GET /release_notes/1.json
  def show
  end

  # GET /release_notes/new
  def new
    @release_note = ReleaseNote.new
  end

  # GET /release_notes/1/edit
  def edit
  end

  # POST /release_notes
  # POST /release_notes.json
  def create
    @release_note = ReleaseNote.new(release_note_params)

    respond_to do |format|
      if @release_note.save
        format.html { redirect_to @release_note, notice: 'Release note was successfully created.' }
        format.json { render :show, status: :created, location: @release_note }
      else
        format.html { render :new }
        format.json { render json: @release_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_notes/1
  # PATCH/PUT /release_notes/1.json
  def update
    respond_to do |format|
      if @release_note.update(release_note_params)
        format.html { redirect_to @release_note, notice: 'Release note was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_note }
      else
        format.html { render :edit }
        format.json { render json: @release_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_notes/1
  # DELETE /release_notes/1.json
  def destroy
    @release_note.destroy
    respond_to do |format|
      format.html { redirect_to release_notes_url, notice: 'Release note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release_note
      @release_note = ReleaseNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_note_params
      params.require(:release_note).permit(:release_date, :note, :title, :release_type)
    end
end
