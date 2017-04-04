class SubscribersController < ApplicationController
	
	before_filter :authenticate_user!

	def new
	end

	def update
		token = params[:stripeToken]

		customer = Stripe::Customer.create(
			card: token,
			plan: 1000,
			email: current_user.email
			)

		current_user.subscribed = true
		current_user.stripeid = customer.id
		current_user.save

		redirect_to programadmin_dash_path
	end

	def cancel_plan
		stripe_subscription = Stripe::Subscription.retrieve(current_user.stripeid)
		stripe_subscription.delete(:at_period_end => true)
		current_user.subscribed = false;
	end
end