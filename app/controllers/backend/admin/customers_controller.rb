class Backend::Admin::CustomersController < Backend::Admin::AdminsController
  def index
    @customers = Customer.all || []
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer =  Customer.create(customer_params)
    if @customer.errors.any?
      flash[:errors] = @customer.errors.full_messages
      render 'new'
    else
      flash[:success] = "You have successfully created an customer."
      redirect_to admin_customers_url
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name , :email ,:phone , :street , :city , :postcode , :gender)
  end
end
