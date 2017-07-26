class Programadmin::BaseController < ApplicationController
	before_filter :require_programadmin!
	

  def index
    @thisPage = "DASHBOARD"
    @title = "Dashboard"
    @subtitle = "Your Admin Dashboard"
    @my_organization = Organization.where(:id => current_user.organization_id.to_s).first
	
	@has_org = !@my_organization.blank?

	#If current user subscribed, check for an organization. Else, redirect to new_subscriber
	if current_user.subscribed?
		# If current user has an org
		if @has_org
			get_projects
			get_cycles
			@has_projects = @my_projects.count > 0
			@has_cycles = @my_cycles.count > 0
			if @has_cycles && @has_projects
				@registered = true
			else
				@registered = false
			end
		end # End has org

		# If user is registered
		if @registered
			get_projects
			get_cycles
			get_applicants
			get_requests
			get_amount_requested(@requests)
			get_amount_awarded(@awarded)
			get_giving_goal_stats
			get_applicant_demographics
			get_request_history
			get_closed_cycle_data
			get_average_rates
			get_repeat_applicants
		end #End @registered
	else
		redirect_to new_subscriber_path
	end#is subscribed

  end#End Index

  def notsubscribed
  end



  def get_applicant_demographics
  	@male_applicants = @all_applicants.where(:gender => "Male").count
	@female_applicants = @all_applicants.where(:gender => "Female").count
	@other_gender_applicants = @all_applicants.where(:gender => "Other").count
	@decline_gender_applicants = @all_applicants.where(:gender => "Prefer not to say").count
	
	@white_applicants = @all_applicants.where(:race => "White").count
	@hispanic_applicants = @all_applicants.where(:race => 'Hispanic, Latino, Spanish Origin').count
	@black_applicants = @all_applicants.where(:race => 'Black or African American').count
	@native_american_applicants = @all_applicants.where(:race => 'American Indian, Alaska Native').count
	@middle_eastern_applicants = @all_applicants.where(:race => 'Middle Eastern, North African').count
	@hawaiian_applicants = @all_applicants.where(:race => 'Native Hawaiian, Pacific Islander').count
	@two_race_applicants = @all_applicants.where(:race => 'Two or more races').count
	@other_race_applicants = @all_applicants.where(:race => 'Other').count

	@applicants_18_under = @all_applicants.where(:age.lte => 18).count
	@applicants_18_to_24 = @all_applicants.where(:age.gte => 19).where(:age.lte => 24).count
	@applicants_25_to_29 = @all_applicants.where(:age.gte => 25).where(:age.lte => 29).count 
	@applicants_30_to_39 = @all_applicants.where(:age.gte => 30).where(:age.lte => 39).count 
	@applicants_40_to_49 = @all_applicants.where(:age.gte => 40).where(:age.lte => 49).count 
	@applicants_50_to_59 = @all_applicants.where(:age.gte => 50).where(:age.lte => 59).count
	@applicants_60_to_69 = @all_applicants.where(:age.gte => 60).where(:age.lte => 69).count
	@applicants_70_plus = @all_applicants.where(:age.gte => 70).count
  end

  def get_request_history
  	@trailing_1 = 1.months.ago.strftime("%Y-%m")
	@trailing_2 = 2.months.ago.strftime("%Y-%m")
	@trailing_3 = 3.months.ago.strftime("%Y-%m")
	@trailing_4 = 4.months.ago.strftime("%Y-%m")
	@trailing_5 = 5.months.ago.strftime("%Y-%m")
	@trailing_6 = 6.months.ago.strftime("%Y-%m")
	@trailing_1_count = @requests.where(submitted_date: (1.months.ago..Time.now)).count
	@trailing_2_count = @requests.where(submitted_date: (2.months.ago..1.months.ago)).count
	@trailing_3_count = @requests.where(submitted_date: (3.months.ago..2.months.ago)).count
	@trailing_4_count = @requests.where(submitted_date: (4.months.ago..3.months.ago)).count
	@trailing_5_count = @requests.where(submitted_date: (5.months.ago..4.months.ago)).count
	@trailing_6_count = @requests.where(submitted_date: (6.months.ago..5.months.ago)).count
  end

  def get_projects
  	@my_projects = Project.where(:organization_id => current_user.organization_id)
  end

  def get_cycles
	@my_cycles = Cycle.where(:organization_id => current_user.organization_id)
  end

  def get_applicants
	@all_applicants = User.where(:organization_id => current_user.organization_id).where(:applicant => true)
  end

  def get_requests
	@requests = Request.where(:organization_id => current_user.organization_id.to_s)
		@awarded = @requests.where(:accepted => "true")
  end

  def get_amount_requested(requests)
  	@amount_requested = 0.0
	requests.each do |this_request|
		@amount_requested += this_request.amount_requested.to_f
	end
  end

  def get_amount_awarded(requests)
  	@amount_given = 0.0
	requests.each do |this_award|
		@amount_given += this_award.amount_awarded.to_f
	end
  end

  def get_giving_goal_stats
  	if @my_organization.annual_giving_goal
		@giving_goal = @my_organization.annual_giving_goal
		if @amount_given > 0.0
			@giving_goal_completion = ((@amount_given / @giving_goal).round(2)) * 100
		else
			@giving_goal_completion = 0
		end
	else
		@giving_goal_completion = 0
	end

	given_last_month_awards = @awarded.where(submitted_date: (1.months.ago..Time.now))
	@given_last_month = 0.0
	given_last_month_awards.each do |this_award|
		@given_last_month += this_award.amount_awarded
	end
  end

  def get_closed_cycle_data
  	@closed_cycles = @my_cycles.where(:status => "Closed")
	@closed_cycles = @closed_cycles[0,5]
	@abbrev_cycles = @closed_cycles

	@closed_acceptance_rate = Array.new
	@closed_acceptance_raw = Array.new	
	@closed_incomplete_rate = Array.new
	@closed_incomplete_raw = Array.new
	@closed_rejection_rate = Array.new
	@closed_rejection_raw = Array.new
	@closed_requests_raw = Array.new
	@closed_requests_rate = Array.new
	
	@avg_accepted_total = 0.0
	@avg_incomplete_total = 0.0
	@avg_rejected_total = 0.0
	@avg_application_total = 0.0

	@amount_given_array = Array.new

	@closed_cycles.each do |this_cycle|
		all_requests = Request.where(:cycle_id => this_cycle.id)
		this_all = all_requests.count

		# Amount Given
		this_given = 0.0
		all_requests.each do |this_req|
			this_given += this_req.amount_awarded.to_f
		end
		@amount_given_array << this_given


		# Total Request Rate
		application_rate = this_all
		@closed_requests_rate << application_rate
		@closed_requests_raw << this_all
		@avg_application_total += application_rate

	
		# Accepted
		this_accepted = Request.where(:cycle_id => this_cycle.id).where(:accepted => true).count
		acceptance_rate = 100 * (((this_all - this_accepted).to_f)/this_all.to_f).round(2)
		@closed_acceptance_rate << acceptance_rate
		@closed_acceptance_raw << this_accepted
		@avg_accepted_total += acceptance_rate
	
		# Incomplete
		this_incomplete = Request.where(:cycle_id => this_cycle.id).where(:status => "Incomplete").count
		incomplete_rate = 100 * ( 1- ((this_all - this_incomplete).to_f)/this_all.to_f).round(2)
		@closed_incomplete_rate << incomplete_rate
		@closed_incomplete_raw << this_incomplete
		@avg_incomplete_total += incomplete_rate
	
		# Rejected
		this_rejected = Request.where(:cycle_id => this_cycle.id).where(:rejected => true).count
		rejection_rate = 100 * (((this_all - this_rejected).to_f)/this_all.to_f).round(2)
		@closed_rejection_rate << rejection_rate
		@closed_rejection_raw << this_rejected
		@avg_rejected_total += rejection_rate
	end
  end

  def get_average_rates
  	@avg_accepted_rate = (@avg_accepted_total / @closed_cycles.length).round(2)
	@avg_incomplete_rate = (@avg_incomplete_total / @closed_cycles.length).round(2)
	@avg_rejected_rate = (@avg_rejected_total / @closed_cycles.length).round(2)
	@avg_applicant_rate = (@avg_application_total / @closed_cycles.length).round(2)
	@avg_amount_given = (@amount_given / @closed_cycles.length).round(2)
  end

  def get_repeat_applicants
  	@repeat_raw = 0
	@all_applicants.each do |this_applicant|
		their_requests_ct = Request.where(:user_id => this_applicant.id.to_s).count
		if their_requests_ct > 1
			@repeat_raw += 1
		end
	end
  end

end#End Controller
