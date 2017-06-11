class Backend::Admin::EmployeesController < Backend::Admin::AdminsController

  def index

  end

  def new
    @employee = User.new(type: 'Employee')
  end

  def create
    @employee =  Employee.invite!(employee_params , current_user)
    if @employee.errors.any?
      flash[:errors] = @employee.errors.full_messages
      render 'new'
    else
      flash[:success] = "You have successfully created an employee."
      redirect_to admin_employees_url
    end
  end

  private

    def employee_params
      params.require(:employee).permit(:first_name, :last_name , :email)
    end
end
