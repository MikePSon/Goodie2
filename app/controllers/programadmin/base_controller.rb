class Programadmin::BaseController < ApplicationController
	before_filter :require_programadmin!
	

  def index
    @thisPage = "DASHBOARD"
    @title = "Dashboard"
    @subtitle = "Your Admin Dashboard"
    @my_organization = Organization.where(:id => current_user.organization_id.to_s).first
    @in_registration = @my_organization.blank?

    
    if !@in_registration
    	@my_projects = Project.where(:organization_id => current_user.organization_id)
    	@my_cycles = Cycle.where(:organization_id => current_user.organization_id)
	
    	@all_applicants = User.where(:organization_id => current_user.organization_id).where(:applicant => true)
    	@requests = Request.where(:organization_id => current_user.organization_id.to_s)
    	@awarded = @requests.where(:accepted => "true")
    	@amount_given = 0.0
    	@awarded.each do |this_award|
    		@amount_given += this_award.amount_awarded.to_f
    	end
    	@amount_requested = 0.0
    	@requests.each do |this_request|
    		@amount_requested += this_request.amount_requested.to_f
    	end
    	#to_reach_giving_goal = (@my_organization.annual_giving_goal - @amount_given).to_f
    	#@giving_goal_completion = ((1-(to_reach_giving_goal / @my_organization.annual_giving_goal))*100).round(0)
    	@giving_goal_completion = 20
	
    	#Closed Cycle Data
    	closed_cycles = @my_cycles.where(:status => "Closed")
    	closed_cycles = closed_cycles[0,5]
    	@abbrev_cycles = closed_cycles
	
		@closed_acceptance_rate = Array.new
		@closed_acceptance_raw = Array.new	
		@closed_incomplete_rate = Array.new
		@closed_incomplete_raw = Array.new
		@closed_rejection_rate = Array.new
		@closed_rejection_raw = Array.new
		
		avg_accepted_total = 0.0
		avg_incomplete_total = 0.0
		avg_rejected_total = 0.0
		closed_cycles.each do |this_cycle|
			this_all = Request.where(:cycle_id => this_cycle.id).count
		
			# Accepted
			this_accepted = Request.where(:cycle_id => this_cycle.id).where(:accepted => true).count
			acceptance_rate = 100 * (((this_all - this_accepted).to_f)/this_all.to_f).round(2)
			@closed_acceptance_rate << acceptance_rate
			@closed_acceptance_raw << this_accepted
			avg_accepted_total += acceptance_rate
		
			# Incomplete
			this_incomplete = Request.where(:cycle_id => this_cycle.id).where(:status => "Incomplete").count
			incomplete_rate = 100 * ( 1- ((this_all - this_incomplete).to_f)/this_all.to_f).round(2)
			@closed_incomplete_rate << incomplete_rate
			@closed_incomplete_raw << this_incomplete
			avg_incomplete_total += incomplete_rate
		
			# Rejected
			this_rejected = Request.where(:cycle_id => this_cycle.id).where(:rejected => true).count
			rejection_rate = 100 * (((this_all - this_rejected).to_f)/this_all.to_f).round(2)
			@closed_rejection_rate << rejection_rate
			@closed_rejection_raw << this_rejected
			avg_rejected_total += rejection_rate
		end
		
		@avg_accepted_rate = (avg_accepted_total / closed_cycles.length).round(2)
		@avg_incomplete_rate = (avg_incomplete_total / closed_cycles.length).round(2)
		@avg_rejected_rate = (avg_rejected_total / closed_cycles.length).round(2)
	
		# Repeat Applicants
		@repeat_raw = 0
		@all_applicants.each do |this_applicant|
			their_requests_ct = Request.where(:user_id => this_applicant.id.to_s).count
			if their_requests_ct > 1
				@repeat_raw += 1
			end
		end
	else #User just registered, has no organizations
		@test = "Need to create how-to to instruct user on how to get up and running. Do in documentation phase"
	end

  end#End Index
end#End Controller
