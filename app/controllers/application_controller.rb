class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #accepts_nested_attributes_for :address

  before_filter :configure_permitted_parameters, if: :devise_controller?


  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :first_name,
      :last_name,
      :admin,
      :password,
      :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email,
      :first_name,
      :last_name,
      :admin,
      :password,
      :password_confirmation,
      :current_password)
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    inside_path
  end

  # Only permits admin users
  def require_admin!
    authenticate_user!

    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end
  helper_method :require_admin!

end
