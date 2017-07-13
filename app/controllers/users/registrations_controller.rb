class Users::RegistrationsController < Devise::RegistrationsController
  # DELETE /resource  
  def destroy
    # Delete stripe acct
    if current_user.program_admin?
      stripe_customer = Stripe::Customer.retrieve(current_user.stripeid)
      my_subscription = stripe_customer.subscriptions.first
      my_subscription.delete(:at_period_end => true)
    end

    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)  
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
      respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  def after_sign_up_path_for(resource)
    if current_user.applicant?
      applicant_dash_path
    elsif current_user.subscribed?
      #this method used by test only
      programadmin_dash_path
    else
      '/subscribers/new'
    end
  end

end