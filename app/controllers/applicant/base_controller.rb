class Applicant::BaseController < ApplicationController
	before_filter :require_applicant!

  def index
    @thisPage = "DASHBOARD"
    @title = "Dashboard"
    @subtitle = "Your Dashboard"
    @primaryAction = true
    @primaryActionText = "New Request"
    @primaryActionPath = new_request_path

    @yourRequests = Request.where(:user_id => current_user.id)
  end
end
