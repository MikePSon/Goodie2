class Admin::BaseController < ApplicationController
  before_filter :require_admin!

  def index
    @test = "Hello"
    @requests = Request.all
    @thisPage = "ADMINDASH"

    @total_amt_given = 0.00
    @total_awards = 0

    @requests.each do |thisRequest|
      if thisRequest.amount_awarded?
        @total_amt_given += thisRequest.amount_awarded
      end
      
      if thisRequest.awarded?
        @total_awards += 1
      end
    end #End all requests loop

  end
end
