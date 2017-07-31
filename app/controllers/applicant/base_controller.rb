class Applicant::BaseController < ApplicationController
	before_filter :require_applicant!

  def index
    @thisPage = "DASHBOARD"
    @title = "Dashboard"
    @subtitle = "Your Dashboard"
    
    #Has bug, page depends on having a cycle param, which you don't want to pass here
    #@primaryAction = true
    #@primaryActionText = "New Request"
    #@primaryActionPath = new_request_path

    @org_cycles = Cycle.where(:organization_id => current_user.organization.id).where(:status => "Open")
    @your_requests = Request.where(:user_id => current_user.id)

    #Total Requested, needs refactor
    @total_requested = 0
    @your_requests.each do |this_req|
      @total_requested += this_req.amount_requested
    end
    @total_awards = @your_requests.where(:accepted => true)
  end
end
