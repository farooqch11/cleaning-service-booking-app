class Backend::Admin::AdminsController < Backend::BackendController

  before_action :check_user

  def check_user
    if current_user.class.name == "Employee"
      redirect_to employee_dashboard_path
      flash[:notice] = "You are not Authorized to Access"
    else
      return true
    end
  end

end
