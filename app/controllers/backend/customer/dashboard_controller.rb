class Backend::Employee::DashboardController < Backend::Customer::CustomersController

  before_action :set_customer ,only:[:edit,:update]

  def index
  end

  def profile
  end

  def edit
  end

  def update
    if current_user.update(customer_params)
      flash[:notice] = 'Customer was successfully updated.'
      # redirect_to employee_profile_path
    else
      flash[:errors] = @customer.errors.full_messages
      render action: 'edit'
    end
  end

  def set_customer
    @customer =  User.find_by_id_and_type(params[:id] , 'Customer')
  end


  def customer_params
    params.require(:customer).permit(:first_name, :last_name , :email ,:phone , :street , :city , :postcode , :gender)
  end


end
