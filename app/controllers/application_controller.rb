class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #accepts_nested_attributes_for :address

  before_filter :configure_permitted_parameters, if: :devise_controller?


  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email, :first_name, :last_name,
      :admin, :program_admin, :program_manager, :applicant,
      :address_1, :address_2, :city, :state, :zip,
      :phone, :office_open, :office_close, :job_title,
      :password, :password_confirmation,
      :organization_id)
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email, :first_name, :last_name,
      :admin, :program_admin, :program_manager, :applicant,
      :address_1, :address_2, :city, :state, :zip,
      :phone, :office_open, :office_close, :job_title,
      :password, :password_confirmation, :current_password,
      :organization_id)
    }
  end

  # Redirects on successful sign in
  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    if resource.admin?
      inside_path
    elsif resource.program_admin?
      programadmin_dash_path
    elsif resource.program_manager?
      programmanager_dash_path
    elsif resource.applicant?
      applicant_dash_path
    else
      inside_path
    end
  end

  # Only permits admin users
  def require_admin!
    authenticate_user!

    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end
  helper_method :require_admin!

  def require_programadmin!
    authenticate_user!
  end
  helper_method :require_programadmin!

  def require_programmanager!
    authenticate_user!
  end
  helper_method :require_programmanager!

  def require_applicant!
    authenticate_user!
  end
  helper_method :require_applicant!

  def require_noapplicant!
    authenticate_user!
    if current_user && current_user.applicant?
      redirect_to applicant_dash_path
    end
  end
  helper_method :require_noapplicant!

end
