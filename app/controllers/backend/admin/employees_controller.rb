class Backend::Admin::EmployeesController < Backend::Admin::AdminsController

  before_action :set_employee ,only: [:edit ,:update , :destroy , :show]

  def index
    @search    = User.where(type: 'Employee').search(params[:q])
    @employees = @search.result.paginate(page: params[:page], per_page: 10) || []
  end

  def show

  end

  def edit
  end


  def update
    if @employee.update(employee_params)
      flash[:notice] = 'Employee was successfully updated.'
      redirect_to admin_employees_url
    else
      flash[:errors] = @employee.errors.full_messages
      render action: 'edit'
    end

  end

  def destroy
    @employee.destroy
    flash[:notice] = 'Employee was successfully Deleted.'
    redirect_to admin_employees_url
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = User.where(type: 'Employee').invite!(employee_params , current_user)
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
      params.require(:employee).permit(:first_name, :last_name ,:role , :color ,:email,:hourly_rate, :street, :city,:postcode,:picture)
    end

  def set_employee
      @employee =  User.find_by_id_and_type(params[:id] , 'Employee')
  end

end
