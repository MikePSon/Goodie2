class SubscribersController < ApplicationController
	
	before_filter :authenticate_user!

	def new
		@plans = Stripe::Plan.all
	end

	def update
		token = params[:stripeToken]
		plan_id = params[:plan_id]

		customer = Stripe::Customer.create(
			card: token,
			plan: plan_id,
			email: current_user.email
			)

		current_user.subscribed = true
		current_user.stripeid = customer.id

		subsid = Stripe::Subscription.retrieve(customer.subscription.id)
		current_user.subscriptionid = subs_id
		
		current_user.save

		redirect_to programadmin_dash_path
	end
end