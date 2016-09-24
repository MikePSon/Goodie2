class Applicant::RequestsController < ApplicationController
	before_filter :require_applicant!

  def index
    @thisPage = "YOUR_REQUESTS"
    @your_requests = Request.where(:user_id => current_user.id.to_s)
    @open_cycles = Cycle.where(:status => "Open").where(:organization_id => current_user.organization_id)

    # Need to build out primary contact on organization
    @primary_contact = User.where(:program_admin => true).where(:organization_id => current_user.organization_id.to_s).first
  end
end
