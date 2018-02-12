class Backend::Admin::EmployeesController < Backend::Admin::AdminsController

  before_action :set_resource ,only: [:edit ,:update , :destroy , :show]
  before_action :new_resource ,only: [:new]

  def index
    @search    = User.where(type: 'Employee').search(params[:q])
    @employees = @search.result.paginate(page: params[:page], per_page: 10).decorate || []
  end

  def show

  end


  def update
    employee_params.delete(:password) if employee_params[:password].blank?
    employee_params.delete(:password_confirmation) if employee_params[:password].blank?
    respond_to do |format|
      if@employee.update(employee_params)
        flash.now[:success] = 'Employee was successfully updated.'
        format.html { redirect_to admin_employees_url }
        format.json { render action: 'show', status: :created, location: @employee }
        format.js   { update_render @employee}
      else
        puts @employee.errors.full_messages
        flash.now[:errors] = @employee.errors.full_messages
        format.html { render action: 'edit' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        format.js   { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @employee.destroy
  #   flash[:notice] = 'Employee was successfully Deleted.'
  #   redirect_to admin_employees_url
  # end

  def create
    @employee = User.new(employee_params.merge!({type: 'Employee'}))
    respond_to do |format|
      if @employee.valid? && @employee.save
        flash.now[:success] = 'You have successfully created an employee.'
        format.html { redirect_to admin_employees_url }
        format.json { render action: 'show', status: :created, location: @employee }
        format.js   { create_render @employee }
      else
        puts @employee.errors.full_messages
        flash.now[:errors] = @employee.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        format.js   { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def employee_params
      params.require(:employee).permit(:first_name, :last_name ,:role , :color ,:email,:hourly_rate, :password , :password_confirmation , :street, :city,:postcode,:picture)
    end

  def new_resource
    @employee ||= User.new(type: 'Employee').decorate
  end

  def set_resource
      @employee ||=  User.find_by_id_and_type(params[:id] , 'Employee').decorate
  end

end
