class MailingSubscribersController < ApplicationController
  before_action :set_mailing_subscriber, only: [:show, :edit, :update, :destroy]

  # GET /mailing_subscribers
  # GET /mailing_subscribers.json
  def index
    @mailing_subscribers = MailingSubscriber.all
  end

  # GET /mailing_subscribers/1
  # GET /mailing_subscribers/1.json
  def show
  end

  # GET /mailing_subscribers/new
  def new
    @mailing_subscriber = MailingSubscriber.new
  end

  # GET /mailing_subscribers/1/edit
  def edit
  end

  # POST /mailing_subscribers
  # POST /mailing_subscribers.json
  def create
    @mailing_subscriber = MailingSubscriber.new(mailing_subscriber_params)

    respond_to do |format|
      if @mailing_subscriber.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @mailing_subscriber }
        flash[:success] = "You've been added!"
      else
        format.html { redirect_to root_path }
        flash[:danger] = "Uh oh! Something went wrong!"
      end
    end
  end

  # PATCH/PUT /mailing_subscribers/1
  # PATCH/PUT /mailing_subscribers/1.json
  def update
    respond_to do |format|
      if @mailing_subscriber.update(mailing_subscriber_params)
        format.html { redirect_to @mailing_subscriber, notice: 'Mailing subscriber was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailing_subscriber }
      else
        format.html { render :edit }
        format.json { render json: @mailing_subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailing_subscribers/1
  # DELETE /mailing_subscribers/1.json
  def destroy
    @mailing_subscriber.destroy
    respond_to do |format|
      format.html { redirect_to mailing_subscribers_url, notice: 'Mailing subscriber was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing_subscriber
      @mailing_subscriber = MailingSubscriber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_subscriber_params
      params.require(:mailing_subscriber).permit(:first_name, :last_name, :email, :discount)
    end
end
