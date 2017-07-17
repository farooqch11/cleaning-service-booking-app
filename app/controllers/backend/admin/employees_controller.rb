class Backend::Admin::EmployeesController < Backend::Admin::AdminsController

  require 'will_paginate/array'

  before_action :set_user ,only: [:edit ,:update , :destroy]

  def index
   @employees =  User.all.select{ |attachment| attachment.type == 'Employee' }.paginate(:page => params[:page], :per_page => 10)

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
      params.require(:employee).permit(:first_name, :last_name , :email,:hourly_rate, :street, :city,:postcode,:picture)
    end

  def set_user
      @employee =  Employee.find(params[:id])
  end

end
