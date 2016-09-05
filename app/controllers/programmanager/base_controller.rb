class Programmanager::BaseController < ApplicationController
	before_filter :require_programmanager!

  def index
    @thisPage = "DASHBOARD"
    @title = "Dashboard"
    @subtitle = "Your Admin Dashboard"

    @requests = Request.where(:organization_id => current_user.organization_id.to_s)
    @amtGiven = @requests.sum(:amount_awarded)
  end
end
