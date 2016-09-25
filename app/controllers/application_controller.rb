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
      admin_dash_path
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
      redirect_to admin_dash_path
    end
  end
  helper_method :require_admin!

  def require_programadmin!
    authenticate_user!
    if current_user && !current_user.program_admin?
      redirect_to programadmin_dash_path
    end
  end
  helper_method :require_programadmin!

  def require_programmanager!
    authenticate_user!
    if current_user && !current_user.program_manager?
      redirect_to programmanager_dash_path
    end
  end
  helper_method :require_programmanager!

  def require_applicant!
    authenticate_user!
    if current_user && !current_user.applicant?
      redirect_to applicant_dash_path
    end
  end
  helper_method :require_applicant!

  def require_noapplicant!
    authenticate_user!
    if current_user && current_user.applicant?
      redirect_to applicant_dash_path
    end
  end
  helper_method :require_noapplicant!


  # Validates that non-admins can only view their organization
  def require_myorganization viewing_org_ID
    viewing_org = viewing_org_ID.to_s
    user_organization = Organization.where(:id => current_user.organization_id).first
    if viewing_org != user_organization.id.to_s
      puts "===== USER ATTEMPTED TO ACCESS INCORRECT ORGANIZATION ====="
      redirect_to organization_path(user_organization)
    end
  end
  helper_method :require_myorganization

  #Validates that non admins can only see projects for their organization
  def require_myproject viewing_project_id
    viewing_project = viewing_project_id.to_s
    org_projects = Project.where(:organization_id => current_user.organization_id)
    allowed = false
    org_projects.each do |this_project|
      this_ID = this_project.id.to_s
      if this_ID == viewing_project
        allowed = true
      end
    end
    if !allowed
      redirect_to projects_path
    end
  end
  helper_method :require_myproject

  #Validates that non admins can only see projects for their organization
  def require_mycycle viewing_cycle_id
    puts "***** VERIFYING Cycle"
    viewing_cycle = viewing_cycle_id.to_s
    org_cycles = Cycle.where(:organization_id => current_user.organization_id)
    allowed = false
    org_cycles.each do |this_project|
      this_ID = this_project.id.to_s
      if this_ID == viewing_cycle
        allowed = true
      end
    end
    if !allowed
      redirect_to cycles_path
    end
  end
  helper_method :require_mycycle

end
