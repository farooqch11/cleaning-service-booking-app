class Backend::Admin::CustomersController < Backend::Admin::AdminsController

  before_action :set_resource ,only: [:edit ,:update , :destroy,:show]
  before_action :new_resource ,only: [:new]

  def index
    @search    = Customer.all.search(params[:q])
    @customers = @search.result.paginate(page: params[:page], per_page: PER_PAGE).decorate || []
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash.now[:success] = 'Customer was successfully updated.'
        format.html { redirect_to admin_customers_url }
        format.json { render action: 'show', status: :created, location: @customer }
        format.js   { update_render @customer}
      else
        puts @customer.errors.full_messages
        format.html { render action: 'edit' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        format.js   { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @customer =  Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        flash.now[:success] = 'You have successfully created an customer.'
        format.html { redirect_to admin_customers_url }
        format.json { render action: 'show', status: :created, location: @customer }
        format.js   { create_render @customer }
      else
        puts @customer.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        format.js   { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_resource
    @customer ||=  Customer.find(params[:id]).decorate
  end

  private

  def new_resource
    @customer ||= Customer.new.decorate
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name , :email ,:phone , :street , :city , :postcode , :gender)
  end

end
