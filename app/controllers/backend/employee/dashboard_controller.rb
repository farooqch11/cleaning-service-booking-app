class Backend::Employee::DashboardController < Backend::Employee::EmployeesController

  before_action :set_employee ,only:[:edit,:update]

  def index
  end

  def profile
  end

  def edit
  end

  def update
    if current_user.update(employee_params)
      flash[:notice] = 'Employee was successfully updated.'
      redirect_to employee_profile_path
    else
      flash[:errors] = @employee.errors.full_messages
      render action: 'edit'
    end
  end

  def set_employee
    @employee =  User.find_by_id_and_type(params[:id] , 'Employee')
  end


  def employee_params
    params.require(:employee).permit(:first_name, :last_name , :color ,:email,:hourly_rate, :street, :city,:postcode,:picture)
  end


end
